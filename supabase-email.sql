-- Email Notifications Setup — Run in Supabase SQL Editor

-- 1. Enable pg_net extension for HTTP requests from PostgreSQL
CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

-- 2. Config table for storing API keys securely (RLS blocks all client access)
CREATE TABLE IF NOT EXISTS app_config (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
ALTER TABLE app_config ENABLE ROW LEVEL SECURITY;

-- 3. Store email settings
-- IMPORTANT: Do NOT put your Resend API key here.
-- Set it via the Admin Panel → Settings tab instead.
INSERT INTO app_config (key, value) VALUES
  ('email_from', 'Behind The Business <onboarding@resend.dev>'),
  ('site_url', 'https://lsm-rho.vercel.app')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

-- 4. Admin functions to manage config
CREATE OR REPLACE FUNCTION admin_set_config(p_key TEXT, p_value TEXT)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NOT is_admin() THEN RAISE EXCEPTION 'Not authorized'; END IF;
  INSERT INTO app_config (key, value) VALUES (p_key, p_value)
  ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;
END;
$$;

CREATE OR REPLACE FUNCTION admin_get_config(p_key TEXT)
RETURNS TEXT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE v_val TEXT;
BEGIN
  IF NOT is_admin() THEN RAISE EXCEPTION 'Not authorized'; END IF;
  SELECT value INTO v_val FROM app_config WHERE key = p_key;
  RETURN v_val;
END;
$$;

-- 5. Helper function to send email via Resend API
CREATE OR REPLACE FUNCTION send_email(p_to TEXT, p_subject TEXT, p_html TEXT)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_api_key TEXT;
  v_from TEXT;
BEGIN
  SELECT value INTO v_api_key FROM app_config WHERE key = 'resend_api_key';
  SELECT value INTO v_from FROM app_config WHERE key = 'email_from';
  IF v_api_key IS NULL THEN RETURN; END IF;
  IF v_from IS NULL THEN v_from := 'Behind The Business <onboarding@resend.dev>'; END IF;

  PERFORM net.http_post(
    url := 'https://api.resend.com/emails',
    headers := jsonb_build_object(
      'Authorization', 'Bearer ' || v_api_key,
      'Content-Type', 'application/json'
    ),
    body := jsonb_build_object(
      'from', v_from,
      'to', ARRAY[p_to],
      'subject', p_subject,
      'html', p_html
    )
  );
END;
$$;

-- 6. Admin test email function
CREATE OR REPLACE FUNCTION admin_send_test_email(p_to TEXT, p_html TEXT)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NOT is_admin() THEN RAISE EXCEPTION 'Not authorized'; END IF;
  PERFORM send_email(p_to, 'Test Email - Behind The Business', p_html);
END;
$$;

-- 7. Enrollment welcome email trigger
CREATE OR REPLACE FUNCTION on_enrollment_created()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_email TEXT;
  v_name TEXT;
  v_course_title TEXT;
  v_course_slug TEXT;
  v_site TEXT;
  v_html TEXT;
BEGIN
  SELECT email INTO v_email FROM auth.users WHERE id = NEW.user_id;
  SELECT full_name INTO v_name FROM profiles WHERE id = NEW.user_id;
  SELECT title, slug INTO v_course_title, v_course_slug FROM courses WHERE id = NEW.course_id;
  SELECT value INTO v_site FROM app_config WHERE key = 'site_url';
  IF v_site IS NULL THEN v_site := 'https://lsm-rho.vercel.app'; END IF;
  IF v_name IS NULL OR v_name = '' THEN v_name := split_part(v_email, '@', 1); END IF;

  v_html := format(
    '<div style="font-family:Inter,Arial,sans-serif;background:#F5F3EE;padding:40px 20px">
      <div style="max-width:600px;margin:0 auto">
        <div style="text-align:center;margin-bottom:30px">
          <h1 style="font-family:Georgia,serif;color:#2F3E34;font-size:24px;font-weight:400;margin:0">Behind The Business</h1>
        </div>
        <div style="background:white;padding:40px;border:1px solid #DEDAD4">
          <p style="color:#B66A4A;text-transform:uppercase;letter-spacing:0.18em;font-size:12px;font-weight:500;margin:0 0 8px">Welcome aboard</p>
          <h2 style="font-family:Georgia,serif;color:#2F3E34;font-size:28px;font-weight:400;margin:0 0 20px">You''re enrolled!</h2>
          <p style="color:#6B6A67;line-height:1.6;margin:0 0 16px">Hi %s,</p>
          <p style="color:#6B6A67;line-height:1.6;margin:0 0 24px">You''ve been enrolled in <strong style="color:#2F3E34">%s</strong>. You can start learning right away.</p>
          <a href="%s/courses/%s" style="display:inline-block;background:#2F3E34;color:#F5F3EE;padding:14px 28px;text-decoration:none;font-size:14px;letter-spacing:0.05em">Start Learning</a>
        </div>
        <p style="color:#6B6A67;font-size:12px;text-align:center;margin-top:24px">Behind The Business · tobey@behindthebusiness.net</p>
      </div>
    </div>',
    v_name, v_course_title, v_site, v_course_slug
  );

  PERFORM send_email(v_email, 'Welcome to ' || v_course_title, v_html);
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_enrollment_email
  AFTER INSERT ON enrollments
  FOR EACH ROW EXECUTE FUNCTION on_enrollment_created();

-- 8. Certificate congratulations email trigger
CREATE OR REPLACE FUNCTION on_certificate_created()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_email TEXT;
  v_name TEXT;
  v_course_title TEXT;
  v_cert_number TEXT;
  v_site TEXT;
  v_html TEXT;
BEGIN
  SELECT email INTO v_email FROM auth.users WHERE id = NEW.user_id;
  SELECT full_name INTO v_name FROM profiles WHERE id = NEW.user_id;
  SELECT title INTO v_course_title FROM courses WHERE id = NEW.course_id;
  SELECT value INTO v_site FROM app_config WHERE key = 'site_url';
  IF v_site IS NULL THEN v_site := 'https://lsm-rho.vercel.app'; END IF;
  IF v_name IS NULL OR v_name = '' THEN v_name := split_part(v_email, '@', 1); END IF;
  v_cert_number := COALESCE(NEW.certificate_number, 'N/A');

  v_html := format(
    '<div style="font-family:Inter,Arial,sans-serif;background:#F5F3EE;padding:40px 20px">
      <div style="max-width:600px;margin:0 auto">
        <div style="text-align:center;margin-bottom:30px">
          <h1 style="font-family:Georgia,serif;color:#2F3E34;font-size:24px;font-weight:400;margin:0">Behind The Business</h1>
        </div>
        <div style="background:white;padding:40px;border:1px solid #DEDAD4">
          <p style="color:#B66A4A;text-transform:uppercase;letter-spacing:0.18em;font-size:12px;font-weight:500;margin:0 0 8px">Congratulations</p>
          <h2 style="font-family:Georgia,serif;color:#2F3E34;font-size:28px;font-weight:400;margin:0 0 20px">Course Complete!</h2>
          <p style="color:#6B6A67;line-height:1.6;margin:0 0 16px">Hi %s,</p>
          <p style="color:#6B6A67;line-height:1.6;margin:0 0 8px">You''ve completed <strong style="color:#2F3E34">%s</strong>.</p>
          <p style="color:#6B6A67;line-height:1.6;margin:0 0 24px">Your certificate number: <strong style="color:#2F3E34">%s</strong></p>
          <a href="%s/certificate?id=%s" style="display:inline-block;background:#2F3E34;color:#F5F3EE;padding:14px 28px;text-decoration:none;font-size:14px;letter-spacing:0.05em">View Certificate</a>
        </div>
        <p style="color:#6B6A67;font-size:12px;text-align:center;margin-top:24px">Behind The Business · tobey@behindthebusiness.net</p>
      </div>
    </div>',
    v_name, v_course_title, v_cert_number, v_site, NEW.id
  );

  PERFORM send_email(v_email, 'Certificate Earned - ' || v_course_title, v_html);
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_certificate_email
  AFTER INSERT ON certificates
  FOR EACH ROW EXECUTE FUNCTION on_certificate_created();
