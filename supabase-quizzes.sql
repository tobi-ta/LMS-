-- Run this in your Supabase SQL Editor to create quiz tables

-- 1. Quizzes (one per lesson, optional)
CREATE TABLE quizzes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  lesson_id UUID REFERENCES lessons(id) ON DELETE CASCADE NOT NULL UNIQUE,
  title TEXT NOT NULL DEFAULT 'Lesson Quiz',
  passing_score INT NOT NULL DEFAULT 70
);

-- 2. Quiz questions
CREATE TABLE quiz_questions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
  sort_order INT NOT NULL DEFAULT 1,
  question_text TEXT NOT NULL
);

-- 3. Answer options (4 per question, one correct)
CREATE TABLE quiz_options (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  question_id UUID REFERENCES quiz_questions(id) ON DELETE CASCADE NOT NULL,
  sort_order INT NOT NULL DEFAULT 1,
  option_text TEXT NOT NULL,
  is_correct BOOLEAN NOT NULL DEFAULT false
);

-- 4. Quiz attempts (track user scores)
CREATE TABLE quiz_attempts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
  score INT NOT NULL,
  total INT NOT NULL,
  passed BOOLEAN NOT NULL DEFAULT false,
  attempted_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- 5. Enable RLS on all tables
ALTER TABLE quizzes ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_attempts ENABLE ROW LEVEL SECURITY;

-- 6. Everyone can read quizzes, questions, and options
CREATE POLICY "Anyone can read quizzes" ON quizzes FOR SELECT USING (true);
CREATE POLICY "Anyone can read questions" ON quiz_questions FOR SELECT USING (true);
CREATE POLICY "Anyone can read options" ON quiz_options FOR SELECT USING (true);

-- 7. Users can read their own attempts
CREATE POLICY "Users can read own attempts" ON quiz_attempts FOR SELECT USING (auth.uid() = user_id);

-- 8. Users can insert their own attempts
CREATE POLICY "Users can insert own attempts" ON quiz_attempts FOR INSERT WITH CHECK (auth.uid() = user_id);
