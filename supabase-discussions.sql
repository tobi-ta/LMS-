-- Discussion / Comments Setup — Run in Supabase SQL Editor

-- 1. Comments table (one level of replies supported via parent_id)
CREATE TABLE lesson_comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  parent_id UUID REFERENCES lesson_comments(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE INDEX idx_comments_lesson ON lesson_comments(lesson_id, created_at);
CREATE INDEX idx_comments_parent ON lesson_comments(parent_id);

-- 2. Enable RLS
ALTER TABLE lesson_comments ENABLE ROW LEVEL SECURITY;

-- 3. Authenticated users can read all comments
CREATE POLICY "Authenticated users can read comments" ON lesson_comments
  FOR SELECT USING (auth.uid() IS NOT NULL);

-- 4. Users can insert their own comments
CREATE POLICY "Users can insert own comments" ON lesson_comments
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 5. Users can delete their own comments
CREATE POLICY "Users can delete own comments" ON lesson_comments
  FOR DELETE USING (auth.uid() = user_id);

-- 6. Admins can delete any comment
CREATE POLICY "Admins can delete any comment" ON lesson_comments
  FOR DELETE USING (is_admin());
