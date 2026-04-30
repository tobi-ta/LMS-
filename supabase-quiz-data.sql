-- Quizzes for all 8 lessons of Course 01 (5 questions each)
-- Lesson 1 already has a quiz, so we start from lesson 2

DO $$
DECLARE
  v_course_id UUID;
  v_lesson_id UUID;
  v_quiz_id UUID;
  v_q_id UUID;
BEGIN
  SELECT id INTO v_course_id FROM courses WHERE course_number = 1;

  -- ============================================
  -- LESSON 2: The Dependency Test
  -- ============================================
  SELECT id INTO v_lesson_id FROM lessons WHERE course_id = v_course_id AND lesson_number = 2;

  INSERT INTO quizzes (lesson_id, title, passing_score)
  VALUES (v_lesson_id, 'The Dependency Test', 70) RETURNING id INTO v_quiz_id;

  -- Q1
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 1, 'What is a dependency in business operations?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'A software library your app uses', false),
  (v_q_id, 2, 'A person, tool, or process that other parts of the business rely on to function', true),
  (v_q_id, 3, 'A vendor you buy office supplies from', false),
  (v_q_id, 4, 'A client who pays the most revenue', false);

  -- Q2
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 2, 'Why is it dangerous when a founder is the single point of dependency?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Because founders should focus only on sales', false),
  (v_q_id, 2, 'Because the business cannot operate without them, limiting growth and creating risk', true),
  (v_q_id, 3, 'Because it makes accounting more difficult', false),
  (v_q_id, 4, 'Because employees prefer working independently', false);

  -- Q3
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 3, 'What is the first step in running a dependency test?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Hire a consultant', false),
  (v_q_id, 2, 'Buy new software', false),
  (v_q_id, 3, 'Map out who is responsible for each critical process', true),
  (v_q_id, 4, 'Send a survey to clients', false);

  -- Q4
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'Which question best reveals a dependency risk?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'How much revenue did we make last quarter?', false),
  (v_q_id, 2, 'What happens if this person is unavailable for two weeks?', true),
  (v_q_id, 3, 'What is our marketing budget?', false),
  (v_q_id, 4, 'How many clients do we have?', false);

  -- Q5
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'What is the goal of reducing dependencies?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'To fire people and save money', false),
  (v_q_id, 2, 'To ensure the business can operate even when key people or tools are unavailable', true),
  (v_q_id, 3, 'To make the founder feel less important', false),
  (v_q_id, 4, 'To automate everything with AI', false);

  -- ============================================
  -- LESSON 3: Mapping Your Operational Stack
  -- ============================================
  SELECT id INTO v_lesson_id FROM lessons WHERE course_id = v_course_id AND lesson_number = 3;

  INSERT INTO quizzes (lesson_id, title, passing_score)
  VALUES (v_lesson_id, 'Mapping Your Operational Stack', 70) RETURNING id INTO v_quiz_id;

  -- Q1
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 1, 'What is an "operational stack"?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'The collection of tools, platforms, and systems your business uses to operate', true),
  (v_q_id, 2, 'A pile of printed documents on your desk', false),
  (v_q_id, 3, 'The organizational hierarchy chart', false),
  (v_q_id, 4, 'Your company''s tech support team', false);

  -- Q2
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 2, 'Why do many businesses not know their full tool stack?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Because the tools are too expensive to remember', false),
  (v_q_id, 2, 'Because tools were added over time by different people without a central inventory', true),
  (v_q_id, 3, 'Because the tools are all the same', false),
  (v_q_id, 4, 'Because they only use one tool', false);

  -- Q3
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 3, 'What should you document for each tool in your stack?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Only the price', false),
  (v_q_id, 2, 'The color of its logo', false),
  (v_q_id, 3, 'What it does, who uses it, what it connects to, and what it costs', true),
  (v_q_id, 4, 'How many stars it has on review sites', false);

  -- Q4
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'What is a common sign of stack bloat?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Having only one tool for everything', false),
  (v_q_id, 2, 'Multiple tools doing the same job with no one sure which is the source of truth', true),
  (v_q_id, 3, 'Using free tools instead of paid ones', false),
  (v_q_id, 4, 'Having a dedicated IT team', false);

  -- Q5
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'What is the benefit of mapping your operational stack?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'You can show off to competitors', false),
  (v_q_id, 2, 'You get visibility into redundancies, gaps, and costs across all systems', true),
  (v_q_id, 3, 'You can cancel all subscriptions', false),
  (v_q_id, 4, 'It makes your website load faster', false);

  -- ============================================
  -- LESSON 4: The Risk Register
  -- ============================================
  SELECT id INTO v_lesson_id FROM lessons WHERE course_id = v_course_id AND lesson_number = 4;

  INSERT INTO quizzes (lesson_id, title, passing_score)
  VALUES (v_lesson_id, 'The Risk Register', 70) RETURNING id INTO v_quiz_id;

  -- Q1
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 1, 'What is a risk register?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'A list of employees ranked by performance', false),
  (v_q_id, 2, 'A document that identifies, scores, and tracks operational risks', true),
  (v_q_id, 3, 'A financial report for investors', false),
  (v_q_id, 4, 'A backup of your database', false);

  -- Q2
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 2, 'How should risks typically be scored?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'By how much they cost to fix', false),
  (v_q_id, 2, 'By likelihood of occurring multiplied by impact if they do', true),
  (v_q_id, 3, 'By alphabetical order', false),
  (v_q_id, 4, 'By which department reported them', false);

  -- Q3
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 3, 'Which of the following is an operational risk?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'A competitor launching a new product', false),
  (v_q_id, 2, 'Stock market fluctuations', false),
  (v_q_id, 3, 'Only one person knows how to run payroll and they have no backup', true),
  (v_q_id, 4, 'A change in consumer preferences', false);

  -- Q4
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'What makes a risk "high priority" in the register?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'It was reported by the founder', false),
  (v_q_id, 2, 'It has both high likelihood and high impact on operations', true),
  (v_q_id, 3, 'It involves the most expensive tool', false),
  (v_q_id, 4, 'It was discovered most recently', false);

  -- Q5
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'How often should a risk register be reviewed?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Only when something breaks', false),
  (v_q_id, 2, 'Once when it is created, then never again', false),
  (v_q_id, 3, 'Regularly, as the business evolves and new risks emerge', true),
  (v_q_id, 4, 'Only during annual board meetings', false);

  -- ============================================
  -- LESSON 5: Interview Prompts for the Team
  -- ============================================
  SELECT id INTO v_lesson_id FROM lessons WHERE course_id = v_course_id AND lesson_number = 5;

  INSERT INTO quizzes (lesson_id, title, passing_score)
  VALUES (v_lesson_id, 'Interview Prompts for the Team', 70) RETURNING id INTO v_quiz_id;

  -- Q1
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 1, 'Why should you interview your team during a systems audit?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'To find out who should be fired', false),
  (v_q_id, 2, 'Because the founder''s view of operations is often incomplete — the team sees bottlenecks the founder doesn''t', true),
  (v_q_id, 3, 'To give them a performance review', false),
  (v_q_id, 4, 'To check if they are using the right font in emails', false);

  -- Q2
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 2, 'What type of questions work best in operational interviews?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Yes/no questions about whether they like their job', false),
  (v_q_id, 2, 'Open-ended questions about how work actually flows day to day', true),
  (v_q_id, 3, 'Technical questions about coding', false),
  (v_q_id, 4, 'Questions about their salary expectations', false);

  -- Q3
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 3, 'Which interview question best uncovers a hidden bottleneck?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'What is your favorite tool to use?', false),
  (v_q_id, 2, 'How long have you worked here?', false),
  (v_q_id, 3, 'Where do you get stuck waiting for someone or something before you can continue your work?', true),
  (v_q_id, 4, 'Do you enjoy working from home?', false);

  -- Q4
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'What should you do with the information gathered from team interviews?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Keep it confidential and do nothing', false),
  (v_q_id, 2, 'Use it to blame individuals for problems', false),
  (v_q_id, 3, 'Cross-reference it with your tool inventory and risk register to validate findings', true),
  (v_q_id, 4, 'Share it on social media', false);

  -- Q5
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'What is the most important thing to establish before interviewing team members?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'A strict time limit of 5 minutes', false),
  (v_q_id, 2, 'That this is about improving systems, not evaluating people', true),
  (v_q_id, 3, 'That their answers will determine their bonus', false),
  (v_q_id, 4, 'That the founder already knows all the answers', false);

  -- ============================================
  -- LESSON 6: Building the Roadmap Output
  -- ============================================
  SELECT id INTO v_lesson_id FROM lessons WHERE course_id = v_course_id AND lesson_number = 6;

  INSERT INTO quizzes (lesson_id, title, passing_score)
  VALUES (v_lesson_id, 'Building the Roadmap Output', 70) RETURNING id INTO v_quiz_id;

  -- Q1
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 1, 'What is an infrastructure roadmap?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'A map of your office building', false),
  (v_q_id, 2, 'A prioritized plan showing what to fix, build, or change in your operational systems', true),
  (v_q_id, 3, 'A list of all your competitors', false),
  (v_q_id, 4, 'A marketing calendar', false);

  -- Q2
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 2, 'What inputs feed into building the roadmap?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Only the founder''s opinion', false),
  (v_q_id, 2, 'The tool inventory, risk register, dependency test, and team interview findings', true),
  (v_q_id, 3, 'Customer reviews from Google', false),
  (v_q_id, 4, 'The company''s stock price', false);

  -- Q3
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 3, 'How should roadmap items be prioritized?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'By which is cheapest to fix', false),
  (v_q_id, 2, 'By which the founder finds most interesting', false),
  (v_q_id, 3, 'By risk level, impact on operations, and effort required', true),
  (v_q_id, 4, 'Alphabetically', false);

  -- Q4
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'What makes a roadmap actionable vs. just a wish list?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Making it longer with more items', false),
  (v_q_id, 2, 'Adding colors and graphics', false),
  (v_q_id, 3, 'Each item has a clear owner, timeline, and defined outcome', true),
  (v_q_id, 4, 'Sharing it with the entire company', false);

  -- Q5
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'What should the roadmap NOT include?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'High-risk items that need immediate attention', false),
  (v_q_id, 2, 'Quick wins that can be fixed in a week', false),
  (v_q_id, 3, 'Vague goals like "improve things" with no specific actions', true),
  (v_q_id, 4, 'Long-term infrastructure projects', false);

  -- ============================================
  -- LESSON 7: Sequencing the Fix Plan
  -- ============================================
  SELECT id INTO v_lesson_id FROM lessons WHERE course_id = v_course_id AND lesson_number = 7;

  INSERT INTO quizzes (lesson_id, title, passing_score)
  VALUES (v_lesson_id, 'Sequencing the Fix Plan', 70) RETURNING id INTO v_quiz_id;

  -- Q1
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 1, 'Why does the order of fixes matter?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'It doesn''t — you should fix everything at once', false),
  (v_q_id, 2, 'Some fixes depend on others being in place first, and resources are limited', true),
  (v_q_id, 3, 'Because clients care about the order', false),
  (v_q_id, 4, 'Because it looks better in presentations', false);

  -- Q2
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 2, 'What should you fix first in most cases?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'The most expensive problem', false),
  (v_q_id, 2, 'The newest problem', false),
  (v_q_id, 3, 'Foundation issues that other fixes depend on', true),
  (v_q_id, 4, 'The problem the founder cares about most', false);

  -- Q3
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 3, 'What is a "quick win" in the context of sequencing?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'A fix that costs nothing', false),
  (v_q_id, 2, 'A low-effort change that delivers immediate visible improvement', true),
  (v_q_id, 3, 'Skipping the hard problems', false),
  (v_q_id, 4, 'Hiring someone to do all the work', false);

  -- Q4
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'Why should quick wins be scheduled early in the fix plan?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Because they are the most important fixes', false),
  (v_q_id, 2, 'They build momentum and team confidence that the process is working', true),
  (v_q_id, 3, 'Because they are the hardest to do', false),
  (v_q_id, 4, 'Because clients demand them first', false);

  -- Q5
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'What is the biggest risk of not sequencing your fix plan?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'The team gets bored', false),
  (v_q_id, 2, 'You build on unstable foundations, causing rework and wasted effort', true),
  (v_q_id, 3, 'You spend too much money on consultants', false),
  (v_q_id, 4, 'Your competitors copy your plan', false);

  -- ============================================
  -- LESSON 8: Wrap-Up and Next Steps
  -- ============================================
  SELECT id INTO v_lesson_id FROM lessons WHERE course_id = v_course_id AND lesson_number = 8;

  INSERT INTO quizzes (lesson_id, title, passing_score)
  VALUES (v_lesson_id, 'Course Review — The Systems Audit', 70) RETURNING id INTO v_quiz_id;

  -- Q1
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 1, 'What are the four key outputs of a complete systems audit?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Budget, headcount, revenue, profit', false),
  (v_q_id, 2, 'Tool inventory, risk register, dependency map, and prioritized roadmap', true),
  (v_q_id, 3, 'Website, logo, branding, social media', false),
  (v_q_id, 4, 'Hiring plan, org chart, job descriptions, onboarding docs', false);

  -- Q2
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 2, 'After completing the audit, what is the recommended next step?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Ignore the findings and hope things improve', false),
  (v_q_id, 2, 'Replace all your tools immediately', false),
  (v_q_id, 3, 'Begin the Foundation phase — stabilize and structure your backend systems', true),
  (v_q_id, 4, 'Hire five new employees', false);

  -- Q3
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 3, 'Who should be involved in reviewing the audit findings?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Only the founder', false),
  (v_q_id, 2, 'Only the IT department', false),
  (v_q_id, 3, 'The founder and key team members who operate within the systems daily', true),
  (v_q_id, 4, 'External investors', false);

  -- Q4
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'What is the main mindset shift this course teaches?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Operations don''t matter — focus on sales', false),
  (v_q_id, 2, 'Technology solves everything automatically', false),
  (v_q_id, 3, 'You must understand your current systems before you can improve them', true),
  (v_q_id, 4, 'Outsource everything to freelancers', false);

  -- Q5
  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'How does the Systems Audit relate to the other BTB courses?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'It doesn''t — each course is completely independent', false),
  (v_q_id, 2, 'It replaces the need for other courses', false),
  (v_q_id, 3, 'It is the diagnostic foundation that informs what to build in Courses 02, 03, and 04', true),
  (v_q_id, 4, 'It is the most advanced course and should be taken last', false);

END $$;

-- Also add 2 more questions to Lesson 1's existing quiz to bring it to 5
DO $$
DECLARE
  v_quiz_id UUID;
  v_q_id UUID;
BEGIN
  SELECT q.id INTO v_quiz_id
  FROM quizzes q JOIN lessons l ON q.lesson_id = l.id JOIN courses c ON l.course_id = c.id
  WHERE c.course_number = 1 AND l.lesson_number = 1;

  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 4, 'When is the right time to conduct a systems audit?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'Only when something breaks', false),
  (v_q_id, 2, 'Before scaling, after major changes, or when the founder is the bottleneck', true),
  (v_q_id, 3, 'Only during the first year of business', false),
  (v_q_id, 4, 'Never — audits waste time', false);

  INSERT INTO quiz_questions (quiz_id, sort_order, question_text)
  VALUES (v_quiz_id, 5, 'What is the difference between a systems audit and a financial audit?') RETURNING id INTO v_q_id;
  INSERT INTO quiz_options (question_id, sort_order, option_text, is_correct) VALUES
  (v_q_id, 1, 'They are the same thing', false),
  (v_q_id, 2, 'A systems audit examines how work flows through tools and people, not money', true),
  (v_q_id, 3, 'A financial audit is more important', false),
  (v_q_id, 4, 'A systems audit only looks at software licenses', false);
END $$;
