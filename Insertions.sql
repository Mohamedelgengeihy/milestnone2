USE GamifiedEduPlatform;
--
INSERT INTO Learner (LearnerID, first_name, last_name, Preferred_content_type, Gender, birth_date, country, cultural_background)
VALUES
(1, 'Alice', 'Smith', 'Video', 'Female', '2001-06-15', 'USA', 'Western'),
(2, 'Bob', 'Johnson', 'Text', 'Male', '1999-08-20', 'UK', 'Western'),
(3, 'Charlie', 'Davis', 'Interactive', 'Non-binary', '2000-12-05', 'Canada', 'Western');



INSERT INTO skills VALUES
(1, 'JavaScript'),
(1, 'Python'),
(2, 'Java'),
(3, 'C++');


INSERT INTO learning_preferences (Skill, LearnerID)
VALUES
(1, 1),  -- Alice prefers learning JavaScript
(2, 1),  -- Alice also prefers Python
(1, 2),  -- Bob prefers learning Java
(3, 3);  -- Charlie prefers learning C++


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


INSERT INTO Course (CourseID, Title, Learning_objectives, credit_points, difficulty_level, description, Pre_requisites)
VALUES
(1, 'Introduction to Programming', 'Learn the basics of programming', 3, 'Beginner', 'This course introduces the concepts of programming.', 'None'),
(2, 'Data Structures and Algorithms', 'Understand data structures and algorithms', 4, 'Intermediate', 'A course focusing on data structures and algorithms in computer science.', 'Introduction to Programming');



INSERT INTO CoursePrerequisite (CourseID, Prereq)
VALUES
(2, 1);  -- Data Structures requires Introduction to Programming as a prerequisite


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
(1, 'Intermediate', 'Complete a collaborative project.', 'Collaborative coding project.', 'Collaborate & Code');

-- Collaborative
INSERT INTO Collaborative (QuestID, LearnerID, deadline, Max_num_participants) 
VALUES
(1, 1, 7, 5);

-- Joins
INSERT INTO Joins (LearnerID, deadline, Max_num_participants) 
VALUES
(1, 7, 5);


