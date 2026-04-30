-- Admin Panel Setup — Run in Supabase SQL Editor

-- 1. Add is_admin column to profiles
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT false;

-- 2. Helper function to check admin status (SECURITY DEFINER bypasses RLS)
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT COALESCE(
    (SELECT is_admin FROM profiles WHERE id = auth.uid()),
    false
  );
$$;

-- 3. Function to let admins list all users (auth.users not directly queryable from client)
CREATE OR REPLACE FUNCTION admin_get_users()
RETURNS TABLE (id UUID, email TEXT, created_at TIMESTAMPTZ)
LANGUAGE sql
SECURITY DEFINER
AS $$
  SELECT au.id, au.email::TEXT, au.created_at
  FROM auth.users au
  WHERE is_admin();
$$;

-- 4. Admin policies for courses
CREATE POLICY "Admins can insert courses" ON courses FOR INSERT WITH CHECK (is_admin());
CREATE POLICY "Admins can update courses" ON courses FOR UPDATE USING (is_admin());
CREATE POLICY "Admins can delete courses" ON courses FOR DELETE USING (is_admin());

-- 5. Admin policies for lessons
CREATE POLICY "Admins can insert lessons" ON lessons FOR INSERT WITH CHECK (is_admin());
CREATE POLICY "Admins can update lessons" ON lessons FOR UPDATE USING (is_admin());
CREATE POLICY "Admins can delete lessons" ON lessons FOR DELETE USING (is_admin());

-- 6. Admin can manage enrollments
CREATE POLICY "Admins can read all enrollments" ON enrollments FOR SELECT USING (is_admin());
CREATE POLICY "Admins can insert enrollments" ON enrollments FOR INSERT WITH CHECK (is_admin());
CREATE POLICY "Admins can delete enrollments" ON enrollments FOR DELETE USING (is_admin());

-- 7. Admin can read all lesson progress
CREATE POLICY "Admins can read all progress" ON lesson_progress FOR SELECT USING (is_admin());

-- 8. Admin can read all profiles
CREATE POLICY "Admins can read all profiles" ON profiles FOR SELECT USING (is_admin());

-- 9. Admin can read all quiz attempts
CREATE POLICY "Admins can read all attempts" ON quiz_attempts FOR SELECT USING (is_admin());

-- 10. Admin CRUD on quizzes
CREATE POLICY "Admins can insert quizzes" ON quizzes FOR INSERT WITH CHECK (is_admin());
CREATE POLICY "Admins can update quizzes" ON quizzes FOR UPDATE USING (is_admin());
CREATE POLICY "Admins can delete quizzes" ON quizzes FOR DELETE USING (is_admin());

-- 11. Admin CRUD on quiz_questions
CREATE POLICY "Admins can insert questions" ON quiz_questions FOR INSERT WITH CHECK (is_admin());
CREATE POLICY "Admins can update questions" ON quiz_questions FOR UPDATE USING (is_admin());
CREATE POLICY "Admins can delete questions" ON quiz_questions FOR DELETE USING (is_admin());

-- 12. Admin CRUD on quiz_options
CREATE POLICY "Admins can insert options" ON quiz_options FOR INSERT WITH CHECK (is_admin());
CREATE POLICY "Admins can update options" ON quiz_options FOR UPDATE USING (is_admin());
CREATE POLICY "Admins can delete options" ON quiz_options FOR DELETE USING (is_admin());
