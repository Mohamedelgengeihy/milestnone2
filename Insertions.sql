USE GENGO


-- Insert users into the Users table
INSERT INTO Users (email, password, full_name, user_type)
VALUES 
('admin1@example.com', 'adminpassword', 'Admin One', 'admin'), -- Admin
('learner1@example.com', 'learnerpassword', 'Learner One', 'learner'), -- Learner
('instructor1@example.com', 'instructorpassword', 'Instructor One', 'instructor'), -- Instructor
('learner2@example.com', 'securelearner', 'Learner Two', 'learner'); -- Another Learner

-- Insert into Learner
INSERT INTO Learner (LearnerID, first_name, last_name, Gender, birth_date, country,Email, cultural_background)
VALUES 
    (1, 'John', 'Doe', 'Male', '1995-06-15', 'USA','John@example.com', 'American'),
    (2, 'Jane', 'Smith', 'Female', '1997-04-22', 'Canada','smith@example.com', 'Canadian');

    INSERT INTO Admin (Name, Email, Password, Role)
VALUES 
('Admin1', 'admin1@example.com', 'password123', 'SuperAdmin'),
('Admin2', 'admin2@example.com', 'password456', 'Admin'),
('Admin3', 'admin3@example.com', 'password789', 'Admin');
SELECT * FROM Admin;




-- Insert into Skills
INSERT INTO skills (LearnerID, skill_name)
VALUES 
    (1, 'Java'),
    (1, 'SQL'),
    (2, 'Python'),
    (2, 'C++');

-- Insert into LearningPreferences
INSERT INTO learning_preferences (preference, LearnerID)
VALUES 
    (1, 1),
    (2, 2);

-- Insert into PersonalizationProfiles
INSERT INTO PersonalizationProfiles (LearnerID, ProfileID, prefered_content_type, emotional_state, personality_type)
VALUES
    (1, 101, 'Video', 'Calm', 'Introvert'),
    (2, 102, 'Article', 'Happy', 'Extrovert');

-- Insert into HealthCondition
INSERT INTO HealthCondtion (LearnerID, ProfileID, condition)
VALUES 
    (1, 101, 'Asthma'),
    (2, 102, 'None');

-- Insert into Course
INSERT INTO Course (CourseID, Title, Learning_objectives, credit_points, difficulty_level, description, Pre_requisites)
VALUES 
    (101, 'Database Management', 'Understand databases', 4, 'Intermediate', 'Detailed course on DBMS',101 ),
    (102, 'Introduction to Programming', 'Learn programming basics', 3, 'Easy', 'Basic course for beginners',102 ),
    (103, 'Data Structures and Algorithms', 'Understand data structures and algorithms', 5, 'Advanced', 'Advanced course on algorithms', 103);
    
-- Insert into CoursePrerequisite
INSERT INTO CoursePrerequisite (CourseID, Prereq)
VALUES
    (102, 101);  -- Prerequisite for 'Introduction to Programming' is 'Database Management'

-- Insert into Module
INSERT INTO Module (ModuleID, CourseID, Title, difficulty_Level, contentURL)
VALUES 
    (1, 101, 'Variables and Data Types', 'Easy', 'http://example.com/module1'),
    (2, 102, 'SQL Basics', 'Intermediate', 'http://example.com/module2'),
    (3, 103, 'Arrays and Linked Lists', 'Advanced', 'http://example.com/module3');
-- Insert into Target_traits
INSERT INTO Target_traits (ModuleID, CourseID, Trait)
VALUES 
    (1, 101, 'Analytical Thinking'),
    (2, 102, 'Problem Solving');

-- Insert into ModuleContent
INSERT INTO ModuleContent (ModuleID, CourseID, content_type)
VALUES 
    (1, 101, 'Lecture'),
    (2, 102, 'Exercise');

-- Insert into ContentLibrary
INSERT INTO ContentLibrary (ID, ModuleID, CourseID, Title, description, metadata, type, content_URL)
VALUES 
    (1, 1, 101, 'Introduction to DB', 'Basic database concepts', 'Introduction, DBMS', 'PDF', 'http://example.com/db_intro'),
    (2, 2, 102, 'Intro to SQL', 'Basic SQL queries', 'SQL, Querying', 'Video', 'http://example.com/sql_intro');

-- Insert into Assessment
INSERT INTO Assessment (AssessmentID, total_marks, CourseID, ModuleID, passing_marks, criteria, weightage, Type, Title, description)
VALUES 
    (1, 100, 101, 1, 50, 'Multiple Choice', 30, 'Quiz', 'Database Basics', 'Basic understanding of DBMS concepts'),
    (2, 100, 102, 2, 50, 'Practical', 40, 'Assignment', 'SQL Queries', 'Hands-on SQL querying exercise');

-- Insert into TakenAssessment
INSERT INTO Takenassessment (AssessmentID, LearnerID, scoredPoint)
VALUES 
    (1, 1, 80),
    (2, 2, 90);


    -- Insert into Learning_activities
INSERT INTO Learning_activities (ActivityID, ModuleID, CourseID, activity_type, instruction_details, Max_points)
VALUES 
    (1, 1, 101, 'Reading', 'Read Chapter 1', 10),
    (2, 2, 102, 'Exercise', 'Complete SQL queries', 15);




INSERT INTO Interaction_log 
VALUES
(1, 1, 1, 30, '2024-11-23 08:00:00', 'Viewed Module Content'),
(2, 2, 1, 45, '2024-11-23 09:00:00', 'Completed Quiz')

select * from Interaction_log





-- Insert into EmotionalFeedback
INSERT INTO EmotionalFeedback ( LearnerID, activityID, timestamp, emotionalState)
VALUES 
    ( 1, 1, '2024-11-29 10:00:00', 'Excited'),
    ( 2, 2, '2024-11-29 11:00:00', 'Confident');

-- Insert into Learning_path
INSERT INTO Learning_path (pathID, LearnerID, ProfileID, completion_status, custom_content, adaptive_rules)
VALUES 
    (1, 1, 101, 'Completed', 'Extra reading material', 'No adaptive rules'),
    (2, 2, 102, 'In Progress', 'Practice assignments', 'Adaptive learning paths based on performance');
-- Insert into Instructor
INSERT INTO Instructor (InstructorID, name, latest_qualification, expertise_area, email)
VALUES
    (1, 'Dr. Smith', 'PhD in Computer Science', 'Databases', 'dr.smith@example.com'),
    (2, 'Prof. Johnson', 'Masters in Programming', 'Programming', 'prof.johnson@example.com');



    INSERT INTO Pathreview (InstructorID, PathID, feedback)
VALUES
    (1, 1, 'Great progress! Keep up the good work.'),
    (2, 2, 'The learner needs to focus more on practical exercises.')


    INSERT INTO Emotionalfeedback_review (FeedbackID, InstructorID, feedback)
VALUES
    (1, 1, 'Learner is progressing well, keep encouraging them.'),
    (2, 2, 'The neutral emotional state indicates the need for more engaging content.')




-- Insert into Course_enrollment
INSERT INTO Course_enrollment (EnrollmentID, CourseID, LearnerID, completion_date, enrollment_date, status)
VALUES 
    (1, 101, 1, '2024-12-01', '2024-10-01', 'Completed'),
    (2, 102, 2, '2024-12-15', '2024-11-01', 'In Progress');

    -- Insert into Teaches
INSERT INTO Teaches (InstructorID, CourseID)
VALUES
    (1, 101),
    (2, 102);


-- Insert into Leaderboard
INSERT INTO Leaderboard (LeaderboardID, season)
VALUES 
    (1, 'Fall 2024');

-- Insert into Ranking
INSERT INTO Ranking (LeaderboardID, LearnerID, CourseID, rank, total_points)
VALUES 
    (1, 1, 101, 1, 95),
    (1, 2, 102, 2, 85);

-- Insert into Learning_goal
INSERT INTO Learning_goal (ID, status, deadline, description)
VALUES 
    (1, 'In Progress', '2024-12-15', 'Master DBMS concepts'),
    (2, 'Completed', '2024-11-30', 'Complete introductory programming');

-- Insert into LearnersGoals
INSERT INTO LearnersGoals (GoalID, LearnerID)
VALUES 
    (1, 1),
    (2, 2);

-- Insert into Survey
INSERT INTO Survey (ID, Title)
VALUES 
    (1, 'Learner Satisfaction Survey'),
    (2, 'Course Feedback Survey');
    SELECT * FROM Survey
-- Insert into SurveyQuestions  
INSERT INTO SurveyQuestions (SurveyID, Question, LearnerID, Answer)
VALUES 
    (1, 'How do you rate the course?', 1, 'Excellent'),
    (2, 'How do you rate the course?', 2, 'Good');
    SELECT * FROM SurveyQuestions

-- Insert into FilledSurvey
INSERT INTO FilledSurvey (SurveyID, Question, LearnerID, Answer)
VALUES 
    (1, 'How do you rate the course?', 1, 'Excellent'),
    (1, 'How do you rate the course?', 2, 'Good');

-- Insert into Notification
INSERT INTO Notification (NotificationID,  message, urgency_level)
VALUES 
    (1,  'Reminder: Course completion deadline approaching', 'High'),
    (2,  'New course available: Data Structures and Algorithms', 'Medium');


-- Insert into ReceivedNotification
INSERT INTO ReceivedNotification (NotificationID, LearnerID)
VALUES 
    (1, 1);

-- Insert into Badge
INSERT INTO Badge (BadgeID, title, criteria, points, Description)
VALUES 
    (1, 'Top Performer', 'Scored 90+ in', 50, 'Awarded for outstanding performance');



    INSERT INTO SkillProgression (id, proficiency_level, LearnerID, skill, timestamp)
VALUES
    (1, 'Beginner', 1, 'Java', '2024-11-29 10:00:00'),
    (2, 'Intermediate', 1, 'SQL', '2024-11-30 12:00:00'),
    (3, 'Advanced', 2, 'Python', '2024-12-01 15:30:00'),
    (4, 'Beginner', 2, 'C++', '2024-12-02 09:00:00'),
    (5, 'Expert', 1, 'SQL', '2024-12-03 17:00:00');
    

-- Insert into Achievement
INSERT INTO Achievement (AchievementID, LearnerID, BadgeID, description, date_earned, type)
VALUES 
    (1, 1, 1, 'Excellent performance in the course', '2024-11-29', 'Academic');

-- Insert into Reward
INSERT INTO Reward (RewardID, value, description, type)
VALUES 
    (1, 100.00, 'Gift card reward for top performer', 'Voucher');

-- Insert into Quest
INSERT INTO Quest (QuestID, difficulty_level, criteria, description, title)
VALUES 
    (1, 'Easy', 'Complete 3 assignments', 'A quest for learners to complete assignments', 'Beginner Quest');

-- Insert into Skill_Mastery
INSERT INTO skill_Mastery (QuestID, LearnerID)
VALUES 
    (1, 1),
    (1, 2);


    INSERT INTO Collaborative (QuestID, deadline, Max_num_participants)
VALUES
    (1,  '2024-12-31', 5)
   
    SELECT * FROM Collaborative
    SELECT * FROM Learner

    INSERT INTO Skill_Mastery_Skill (LearnerID, Skills)
VALUES
    (1, 'Java'),
    (2, 'C++')


  

    INSERT INTO LearnersCollaboration (LearnerID, QuestID, CompletionStatus)
VALUES
    (1, 1, 'Completed'),
    (2, 1, 'In Progress')



    INSERT INTO LearnersMastery (LearnerID, QuestID, CompletionStatus)
VALUES
    (1, 1, 'Mastered'),
    (2, 1, 'Beginner')

    
    
    
    INSERT INTO Discussion_forum ( ModuleID, CourseID, title, last_active, timestamp, description)
VALUES
    ( 1, 101, 'Java Discussion', '2024-10-01 09:00:00', '2024-10-01 10:00:00', 'Discuss Java programming challenges'),
    ( 2, 102, 'C++ Discussion', '2024-10-02 10:00:00', '2024-10-02 11:30:00', 'C++ tips and tricks')
 


      INSERT INTO LearnerDiscussion (ForumID, LearnerID, Post, time)
VALUES
    (1, 1, 'This is my first post!', '2024-10-01 10:00:00'),
    (2, 2, 'I love this course!', '2024-10-02 11:30:00')



    INSERT INTO QuestReward (RewardID, QuestID, LearnerID, Time_earned)
VALUES
    (1, 1, 1, '2024-11-29')
  
    SELECT * FROM QuestReward



    -- Insert users into the Users table
INSERT INTO Users (email, password, full_name, user_type)
VALUES 
('admin1@example.com', 'adminpassword', 'Admin One', 'admin'), -- Admin
('learner1@example.com', 'learnerpassword', 'Learner One', 'learner'), -- Learner
('instructor1@example.com', 'instructorpassword', 'Instructor One', 'instructor'), -- Instructor
('learner2@example.com', 'securelearner', 'Learner Two', 'learner'); -- Another Learner
