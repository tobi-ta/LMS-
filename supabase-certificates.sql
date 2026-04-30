-- Run this in your Supabase SQL Editor to create the certificates table

-- 1. Create the certificates table
CREATE TABLE certificates (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE NOT NULL,
  certificate_number TEXT NOT NULL UNIQUE,
  issued_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  UNIQUE(user_id, course_id)
);

-- 2. Enable Row Level Security
ALTER TABLE certificates ENABLE ROW LEVEL SECURITY;

-- 3. Users can read their own certificates
CREATE POLICY "Users can read own certificates"
  ON certificates FOR SELECT
  USING (auth.uid() = user_id);

-- 4. Users can insert their own certificates (one per course)
CREATE POLICY "Users can insert own certificates"
  ON certificates FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 5. Allow anyone to read a certificate by id (for public verification)
CREATE POLICY "Anyone can verify a certificate"
  ON certificates FOR SELECT
  USING (true);

-- 6. Function to generate a unique certificate number
CREATE OR REPLACE FUNCTION generate_certificate_number()
RETURNS TRIGGER AS $$
DECLARE
  seq INT;
BEGIN
  SELECT COUNT(*) + 1 INTO seq FROM certificates;
  NEW.certificate_number := 'BTB-' || TO_CHAR(NOW(), 'YYYY') || '-' || LPAD(seq::TEXT, 4, '0');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 7. Trigger to auto-generate certificate number on insert
CREATE TRIGGER set_certificate_number
  BEFORE INSERT ON certificates
  FOR EACH ROW
  EXECUTE FUNCTION generate_certificate_number();
