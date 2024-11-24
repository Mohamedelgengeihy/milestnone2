

USE GamifiedEduPlatform;

-- Insert data into the Learner table
INSERT INTO Learner (LearnerID, first_name, last_name, Gender, birth_date, country, cultural_background)
VALUES 
(1, 'Alice', 'Johnson', 'Female', '2001-05-21', 'USA', 'Western'),
(2, 'Bob', 'Smith', 'Male', '1999-12-15', 'Canada', 'Western'),
(3, 'Carlos', 'Diaz', 'Male', '2002-08-05', 'Mexico', 'Latin American');
SELECT * FROM Learner


-- Insert data into Skills table
INSERT INTO skills (LearnerID, skill_name)
VALUES
(1, 'Python'),
(1, 'Data Analysis'),
(2, 'Java'),
(3, 'Web Development'),
(3, 'Database Design');
SELECT * FROM skills

-- Insert data into the PersonalizationProfiles table
INSERT INTO PersonalizationProfiles (LearnerID, ProfileID, prefered_content_type, emotional_state, personality_type)
VALUES 
(1, 1, 'Videos', 'Engaged', 'Introvert'),
(2, 2, 'Quizzes', 'Motivated', 'Extrovert'),
(3, 3, 'Interactive Simulations', 'Curious', 'Analytical');
SELECT * FROM PersonalizationProfiles

-- Insert data into Course table
INSERT INTO Course (CourseID, Title, Learning_objectives, credit_points, difficulty_level, description, Pre_requisites)
VALUES
(101, 'Introduction to Programming', 'Learn programming basics', 3, 'Easy', 'Basic course for beginners', NULL),
(102, 'Database Management', 'Understand databases', 4, 'Intermediate', 'Detailed course on DBMS', NULL);
SELECT * FROM Course


-- Insert data into the CoursePrerequisite table
INSERT INTO CoursePrerequisite (CourseID, Prereq)
VALUES
(2, 1);
SELECT * FROM CoursePrerequisite

-- Insert data into the Module table
INSERT INTO Module (ModuleID, CourseID, Title, difficulty_Level, contentURL)
VALUES
(1, 1, 'Variables and Data Types', 'Easy', 'http://example.com/module1'),
(2, 2, 'SQL Basics', 'Intermediate', 'http://example.com/module2');
SELECT * FROM Module

-- Insert data into the Target_traits table
INSERT INTO Target_traits (ModuleID, CourseID, Trait)
VALUES
(1, 1, 'Logical Thinking'),
(2, 2, 'Problem Solving');
SELECT * FROM Target_traits

-- Insert data into the Assessment table
INSERT INTO Assessment (AssessmentID, total_marks, CourseID, ModuleID, passing_marks, criteria, weightage, Type, Title, description)
VALUES
(1, 100, 1, 1, 50, 'Correctness', 20, 'Quiz', 'Basic Quiz on Variables', 'Test understanding of variables'),
(2, 100, 2, 2, 60, 'Accuracy', 25, 'Assignment', 'SQL Query Practice', 'Practice writing SQL queries');
SELECT * FROM Assessment

-- Insert data into Instructor table
INSERT INTO Instructor (InstructorID, name, latest_qualification, expertise_area, email)
VALUES
(1, 'Dr. Emily Watson', 'PhD', 'Programming', 'emily@example.com'),
(2, 'Prof. Liam Brown', 'MSc', 'Databases', 'liam@example.com');
SELECT * FROM Instructor

-- Insert data into Teaches table
INSERT INTO Teaches (InstructorID, CourseID)
VALUES
(1, 1),
(2, 2);
SELECT * FROM Teaches

-- Insert data into Learning_path table
INSERT INTO Learning_path (pathID, LearnerID, ProfileID, completion_status, custom_content, adaptive_rules)
VALUES
(1, 1, 1, 'In Progress', 'Beginner Content', 'Adaptive based on quiz results'),
(2, 2, 2, 'Completed', 'Database Tutorials', 'Focus on practical exercises');
SELECT * FROM Learning_path

-- Insert data into Reward table
INSERT INTO Reward (RewardID, value, description, type)
VALUES
(1, 50, 'Discount on next course', 'Voucher'),
(2, 20, 'E-book download', 'Digital');
SELECT * FROM Reward

-- Insert data into Notification table
INSERT INTO Notification (NotificationID, timestamp, message, urgency_level)
VALUES
(1, '2024-11-22 10:00:00', 'Welcome to the course!', 'Low'),
(2, '2024-11-22 12:00:00', 'Assignment deadline approaching.', 'High');
SELECT * FROM Notification

-- Insert data into Badge table
INSERT INTO Badge (BadgeID, title, criteria, points, Description)
VALUES
(1, 'Completion Badge', 'Complete the course', 10, 'Awarded for completing a course'),
(2, 'Quiz Master', 'Score 90+ in a quiz', 15, 'Awarded for exceptional performance');
SELECT * FROM Badge

-- Insert data into Achievement table
INSERT INTO Achievement (AchievementID, LearnerID, BadgeID, description, date_earned, type)
VALUES
(1, 1, 1, 'Completed Intro to Programming', '2024-11-20', 'Course Completion'),
(2, 2, 2, 'Achieved high score in a quiz', '2024-11-21', 'Quiz Performance');

SELECT * FROM Achievement

INSERT INTO Leaderboard (LeaderboardID, season)
VALUES
(1, 'Spring 2024'),
(2, 'Summer 2024'),
(3, 'Fall 2024');
SELECT * FROM Leaderboard

INSERT INTO Ranking (LeaderboardID, LearnerID, CourseID, rank, total_points)
VALUES
(1, 1, 101, 1, 950),
(1, 2, 101, 2, 850),
(2, 3, 102, 1, 900),
(2, 1, 102, 2, 870)
select * FROM Ranking

INSERT INTO Learning_goal (ID, status, deadline, description)
VALUES
(1, 'Completed', '2024-06-15', 'Complete all basic programming modules'),
(2, 'Pending', '2024-08-01', 'Earn a badge for advanced database skills'),
(3, 'In Progress', '2024-07-20', 'Participate in a collaborative quest on Python projects');
SELECT * FROM Learning_goal

INSERT INTO LearnersGoals (GoalID, LearnerID)
VALUES
(1, 1),
(2, 2),
(3, 3)
SELECT * FROM LearnersGoals


INSERT INTO Survey (ID, Title)
VALUES
(1, 'Learning Preferences Survey'),
(2, 'Feedback on Module Content'),
(3, 'Instructor Effectiveness Survey');
SELECT * FROM Survey


INSERT INTO SurveyQuestions (SurveyID, Question)
VALUES
(1, 'What is your preferred learning style?'),
(1, 'How much time can you dedicate daily to learning?'),
(2, 'Was the content engaging?'),
(3, 'How effective was the instructor in teaching the course?');
SELECT * FROM SurveyQuestions


INSERT INTO FilledSurvey (SurveyID, Question, LearnerID, Answer)
VALUES
(1, 'What is your preferred learning style?', 1, 'Visual'),
(1, 'How much time can you dedicate daily to learning?', 1, '2 hours'),
(2, 'Was the content engaging?', 2, 'Yes'),
(3, 'How effective was the instructor in teaching the course?', 3, 'Very Effective');
SELECT * FROM FilledSurvey



INSERT INTO ReceivedNotification (NotificationID, LearnerID)
VALUES
(1, 1),
(2, 2)



INSERT INTO Quest (QuestID, difficulty_level, criteria, description, title)
VALUES
(1, 'Easy', 'Complete 5 activities', 'Solve beginner Python challenges', 'Python Starter Quest'),
(2, 'Medium', 'Collaborate with a team', 'Build a project with peers', 'Team Collaboration Quest'),
(3, 'Hard', 'Achieve mastery in algorithms', 'Pass advanced algorithm tests', 'Algorithm Mastery Quest');
SELECT * FROM Quest


INSERT INTO Collaborative (QuestID, LearnerID, deadline, Max_num_participants)
VALUES
(2, 1, 20240630, 5),
(2, 2, 20240630, 5),
(2, 3, 20240630, 5);
SELECT * FROM Collaborative


INSERT INTO Joins (LearnerID, deadline, Max_num_participants)
VALUES
(1, 20240630, 5),
(2, 20240630, 5),
(3, 20240630, 5);
SELECT * FROM Joins

INSERT INTO Skill_Mastery (QuestID, LearnerID)
VALUES
(1, 1),
(3, 2),
(1, 3),
(3, 4);
SELECT * FROM skill_Mastery


INSERT INTO Skill_Mastery_Skill (LearnerID, Skills)
VALUES
(1, 'Python Basics'),
(2, 'Data Structures'),
(3, 'Algorithms'),
(4, 'Database Management');

SELECT * FROM Skill_Mastery_Skill



/*
INSERT INTO Learner (LearnerID, first_name, last_name, Preferred_content_type, Gender, birth_date, country, cultural_background)
VALUES
(1, 'Alice', 'Smith', 'Video', 'Female', '2001-06-15', 'USA', 'Western'),
(2, 'Bob', 'Johnson', 'Text', 'Male', '1999-08-20', 'UK', 'Western'),
(3, 'Charlie', 'Davis', 'Interactive', 'Non-binary', '2000-12-05', 'Canada', 'Western');



INSERT INTO skills VALUES
(1, 'JavaScript'),
(2, 'Python'),
(3, 'Java'),
(4, 'C++');


INSERT INTO learning_preferences (Skill, LearnerID)
VALUES
(1, 1),  
(2, 1),  
(1, 2), 
(3, 3);  


INSERT INTO SkillProgression (ID, proficiency_level, LearnerID, skill_name, timestamp)
VALUES
(1, 2, 1, 'JavaScript', '2024-11-01 10:00:00'),
(2, 3, 1, 'Python', '2024-11-02 11:00:00'),
(3, 1, 2, 'Java', '2024-11-03 09:00:00'),
(4, 2, 3, 'C++', '2024-11-04 08:00:00');


INSERT INTO PersonalizationProfiles (LearnerID, ProfileID, prefered_content_type, emotional_state, personality_type)
VALUES
(1, 1, 'Video', 'Happy', 'Introverted'),
(2, 2, 'Text', 'Neutral', 'Extroverted'),
(3, 3, 'Interactive', 'Excited', 'Ambivert');

IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseID = 1)
BEGIN
    INSERT INTO Course (CourseID, Title, Learning_objectives, credit_points, difficulty_level, description, Pre_requisites)
    VALUES (1, 'Introduction to Programming', 'Learn the basics of programming', 3, 'Beginner', 'This course introduces the concepts of programming.', 'None');
END


INSERT INTO CoursePrerequisite (CourseID, Prereq)
VALUES
(2, 1);  


INSERT INTO Assessment (AssessmentID, total_marks, CourseID, ModuleID, passing_marks, criteria, weightage, Type, Title, description)
VALUES
(1, 100, 1, 1, 50, 'Midterm Exam', 30, 'Exam', 'Intro to Programming Midterm', 'A midterm assessment on the basics of programming.'),
(2, 100, 2, 1, 60, 'Final Exam', 40, 'Exam', 'Data Structures Final', 'A final assessment on data structures and algorithms.');


INSERT INTO Module (ModuleID, CourseID, Title, difficulty_Level, contentURL)
VALUES
(1, 1, 'Introduction to Variables', 'Beginner', 'http://example.com/variables'),
(2, 2, 'Arrays and Lists', 'Intermediate', 'http://example.com/arrays');



INSERT INTO Badge (BadgeID, title, criteria, points, Description)
VALUES
(1, 'JavaScript Beginner', 'Complete 50% of JavaScript course', 10, 'Awarded for completing half of the JavaScript course.');


INSERT INTO Course_enrollment (EnrollmentID, CourseID, LearnerID, completion_date, enrollment_date, status)
VALUES
(1, 1, 1, '2024-12-01', '2024-11-01', 'In Progress'),
(2, 2, 2, '2024-12-10', '2024-11-05', 'In Progress');


INSERT INTO Notification (ID, timestamp, message, urgency_level)
VALUES
(1, '2024-11-01 08:00:00', 'You have a new assignment due soon.', 'High'),
(2, '2024-11-02 09:30:00', 'Reminder: Your course enrollment is about to expire.', 'Medium');


INSERT INTO Ranking (LeaderboardID, LearnerID, CourseID, rank, total_points)
VALUES
(1, 1, 1, 1, 90),
(2, 2, 1, 2, 85);


-- Discussion_forum
INSERT INTO Discussion_forum (forumID, ModuleID, CourseID, title, last_active, timestamp, description) 
VALUES
(1, 1, 1, 'Introduction to Programming Forum', '2024-11-20', '2024-11-20 12:00:00', 'Discuss programming basics.'),
(2, 2, 2, 'Data Structures Forum', '2024-11-21', '2024-11-21 15:00:00', 'Share ideas about algorithms.');

-- Target_traits
INSERT INTO Target_traits (ModuleID, CourseID, Trait) 
VALUES
(1, 1, 'Logical Thinking'),
(2, 2, 'Problem Solving');

-- ModuleContent
INSERT INTO ModuleContent (ModuleID, CourseID, content_type) 
VALUES
(1, 1, 'Video'),
(1, 1, 'Text'),
(2, 2, 'Interactive');

-- HealthCondition
INSERT INTO HealthCondtion (LearnerID, ProfileID, condition) 
VALUES
(1, 1, 'Color Blindness'),
(2, 2, 'Dyslexia');


-- ContentLibrary
INSERT INTO ContentLibrary (ID, ModuleID, CourseID, Title, description, metadata, type, content_URL) 
VALUES
(1, 1, 1, 'Variables Tutorial', 'Learn about variables.', 'Variables,Basics', 'Video', 'http://example.com/variables-video'),
(2, 2, 2, 'Arrays Tutorial', 'Explore arrays.', 'Arrays,Intermediate', 'Interactive', 'http://example.com/arrays-interactive');

-- Learning_activities
INSERT INTO Learning_activities (ActivityID, ModuleID, CourseID, activity_type, instruction_details, Max_points) 
VALUES
(1, 1, 1, 'Quiz', 'Answer 10 questions about variables.', 20),
(2, 2, 2, 'Assignment', 'Complete an array implementation task.', 50);

-- Learning_path
INSERT INTO Learning_path (pathID, LearnerID, ProfileID, completion_status, custom_content, adaptive_rules) 
VALUES
(1, 1, 1, 'In Progress', 'Additional videos for variables.', 'Focus on weak areas'),
(2, 2, 2, 'In Progress', 'Extra quizzes on algorithms.', 'Target algorithm basics');

-- Interaction_log
INSERT INTO Interaction_log (LogID, activity_ID, LearnerID, Duration, Timestamp, action_type) 
VALUES
(1, 1, 1, '00:15:30', '2024-11-01 12:00:00', 'Start Activity'),
(2, 2, 2, '00:45:00', '2024-11-02 14:00:00', 'Submit Activity');



-- Pathreview
INSERT INTO Pathreview (InstructorID, PathID, feedback) 
VALUES
(1, 1, 'Good progress on variables.'),
(2, 2, 'Improve understanding of algorithms.');

-- EmotionalFeedback
INSERT INTO EmotionalFeedback (FeedbackID, LearnerID, timestamp, emotionalState) 
VALUES
(1, 1, '2024-11-01 10:00:00', 'Happy'),
(2, 2, '2024-11-02 14:30:00', 'Neutral');

-- Emotionalfeedback_review
INSERT INTO Emotionalfeedback_review (FeedbackID, InstructorID, feedback) 
VALUES
(1, 1, 'Positive emotional response observed.'),
(2, 2, 'Neutral emotional state, need engagement.');



-- Leaderboard
INSERT INTO Leaderboard (LeaderboardID, season) 
VALUES
(1, 'Fall 2024'),
(2, 'Winter 2024');

-- Ranking
INSERT INTO Ranking (LeaderboardID, LearnerID, CourseID, rank, total_points) 
VALUES
(1, 1, 1, 1, 100),
(1, 2, 2, 2, 80);

-- Learning_goal
INSERT INTO Learning_goal (ID, status, deadline, description) 
VALUES
(1, 'In Progress', '2024-12-01', 'Complete all programming assignments.'),
(2, 'Completed', '2024-11-15', 'Submit final data structures project.');

-- LearnersGoals
INSERT INTO LearnersGoals (GoalID, LearnerID) 
VALUES
(1, 1),
(2, 2);


-- Survey
INSERT INTO Survey (ID, Title) 
VALUES
(1, 'Programming Feedback Survey'),
(2, 'Data Structures Satisfaction Survey');

-- SurveyQuestions
INSERT INTO SurveyQuestions (SurveyID, Question) 
VALUES
(1, 'How clear were the programming concepts?'),
(2, 'Rate the usefulness of the data structures content.');

-- FilledSurvey
INSERT INTO FilledSurvey (SurveyID, Question, LearnerID, Answer) 
VALUES
(1, 'How clear were the programming concepts?', 1, 'Very Clear'),
(2, 'Rate the usefulness of the data structures content.', 2, 'Extremely Useful');

-- Notification
INSERT INTO Notification (ID, timestamp, message, urgency_level) 
VALUES
(1, '2024-11-10 09:00:00', 'Assignment submission due in 2 days.', 'High'),
(2, '2024-11-12 18:00:00', 'Course enrollment confirmation.', 'Medium');

-- ReceivedNotification
INSERT INTO ReceivedNotification (NotificationID, LearnerID) 
VALUES
(1, 1),
(2, 2);


-- Achievement
INSERT INTO Achievement (AchievementID, LearnerID, BadgeID, description, date_earned, type) 
VALUES
(1, 1, 1, 'Achieved 50% completion of JavaScript course.', '2024-11-05', 'Course Completion');

-- Reward
INSERT INTO Reward (RewardID, value, description, type) 
VALUES
(1, 10.00, '10% discount on next course.', 'Discount');

-- Quest
INSERT INTO Quest (QuestID, difficulty_level, criteria, description, title) 
VALUES
(1, 'Intermedcompleteiate', 'Complete a collaborative project.', 'Collaborative coding project.', 'Collaborate & Code');

-- Collaborative
INSERT INTO Collaborative (QuestID, LearnerID, deadline, Max_num_participants) 
VALUES
(1, 1, 7, 5);

-- Joins
INSERT INTO Joins (LearnerID, deadline, Max_num_participants) 
VALUES
(1, 7, 5);

*/
