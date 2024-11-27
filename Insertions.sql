USE GENGO;

INSERT INTO Course (CourseID, Title, Learning_objectives, credit_points, difficulty_level, description, Pre_requisites)
VALUES
    (101, 'Database Management', 'Understand databases', 4, 'Intermediate', 'Detailed course on DBMS', NULL),
    (102, 'Introduction to Programming', 'Learn programming basics', 3, 'Easy', 'Basic course for beginners', NULL),
    (103, 'DSA Management', 'Understand DS ALG', 8, 'Intermediate', 'Detailed course on DSA', NULL),
    (104, 'Advanced SQL', 'Master SQL queries', 5, 'Advanced', 'In-depth SQL course for database experts', NULL);
SELECT * FROM Course;
DELETE FROM Course WHERE CourseID = 104;

INSERT INTO Module (ModuleID, CourseID, Title, difficulty_Level, contentURL)
VALUES
    (1, 103, 'Variables and Data Types', 'Easy', 'http://example.com/module1'),
    (2, 104, 'SQL Basics', 'Intermediate', 'http://example.com/module2');
SELECT * FROM Module;


INSERT INTO Target_traits (ModuleID, CourseID, Trait)
VALUES
    (1, 103, 'Logical Thinking'),
    (1, 103, 'Problem Solving'),
    (2, 104, 'Critical Thinking');
SELECT * FROM Target_traits;


INSERT INTO Learner (LearnerID, first_name, last_name, Gender, birth_date, country, cultural_background)
VALUES
    (1, 'Alice', 'Johnson', 'Female', '2001-05-21', 'USA', 'Western'),
    (2, 'Bob', 'Smith', 'Male', '1999-12-15', 'Canada', 'Western'),
    (3, 'Carlos', 'Diaz', 'Male', '2002-08-05', 'Mexico', 'Latin American');
SELECT * FROM Learner;
DELETE FROM Learner WHERE LearnerID = 3;

INSERT INTO Skills (LearnerID, skill_name)
VALUES
    (1, 'Python'),
    (1, 'Data Analysis'),
    (2, 'Java'),
    (3, 'Web Development'),
    (3, 'Database Design');
SELECT * FROM Skills;


INSERT INTO CoursePrerequisite (CourseID, Prereq)
VALUES
    (103, 101), 
    (104, 102); 
SELECT * FROM CoursePrerequisite;


INSERT INTO Assessment (AssessmentID, total_marks, CourseID, ModuleID, passing_marks, criteria, weightage, Type, Title, description)
VALUES
    (1, 100, 103, 1, 50, 'Correctness', 20, 'Quiz', 'Basic Quiz on Variables', 'Test understanding of variables'),
    (2, 100, 104, 2, 60, 'Accuracy', 25, 'Assignment', 'SQL Assignment', 'Practice writing SQL queries');
SELECT * FROM Assessment;


INSERT INTO Course_enrollment (EnrollmentID, CourseID, LearnerID, completion_date, enrollment_date, status)
VALUES
    (1, 103, 1, '2024-12-15', '2024-09-01', 'In Progress'),
    (2, 104, 2, '2024-11-30', '2024-07-10', 'Completed'),
    (3, 102, 3, '2024-11-20', '2024-06-25', 'In Progress');
SELECT * FROM Course_enrollment;


INSERT INTO Quest (QuestID, difficulty_level, criteria, description, title)
VALUES
    (1, 'Easy', 'Complete 5 activities', 'Solve beginner Python challenges', 'Python Starter Quest'),
    (2, 'Medium', 'Collaborate with a team', 'Build a project with peers', 'Team Collaboration Quest'),
    (3, 'Hard', 'Achieve mastery in algorithms', 'Pass advanced algorithm tests', 'Algorithm Mastery Quest');
SELECT * FROM Quest;


INSERT INTO Reward (RewardID, value, description, type)
VALUES
    (1, 50, 'Discount on next course', 'Voucher'),
    (2, 20, 'E-book download', 'Digital'),
    (3, 100, 'Free course access', 'Voucher');
SELECT * FROM Reward;


INSERT INTO QuestReward (RewardID, QuestID, LearnerID, Time_earned)
VALUES
    (1, 1, 1, '2024-11-20'),
    (2, 2, 2, '2024-11-22'),
    (3, 3, 3, '2024-11-24');
SELECT * FROM QuestReward;


INSERT INTO EmotionalFeedback ( LearnerID, timestamp, emotionalState)
VALUES
    ( 1, '2024-11-01 10:00:00', 'Happy'),
    ( 2, '2024-11-02 14:30:00', 'Neutral'),
    ( 3, '2024-11-25 18:00:00', 'Motivated');
SELECT * FROM EmotionalFeedback;


INSERT INTO TakenAssessment (AssessmentID, LearnerID, scoredPoint)
VALUES
    (1, 1, 85), 
    (1, 2, 90), 
    (2, 3, 88); 
SELECT * FROM TakenAssessment;



INSERT INTO Learning_activities (ActivityID, ModuleID, CourseID, activity_type, instruction_details, Max_points)
VALUES
    (1, 1, 103, 'Quiz', 'Answer questions on variables.', 20),
    (2, 2, 104, 'Assignment', 'Complete SQL project.', 50);
SELECT * FROM Learning_activities;


INSERT INTO Leaderboard (LeaderboardID, season)
VALUES
    (1, 'Spring 2024'),
    (2, 'Summer 2024'),
    (3, 'Fall 2024');
SELECT * FROM Leaderboard;


INSERT INTO Badge (BadgeID, title, criteria, points, Description)
VALUES
    (1, 'Completion Badge', 'Complete a course', 10, 'Awarded for completing a course'),
    (2, 'Quiz Master', 'Score 90%+ in a quiz', 15, 'Awarded for exceptional quiz performance'),
    (3, 'Collaboration Badge', 'Participate in a collaborative quest', 20, 'Awarded for teamwork');
SELECT * FROM Badge;


INSERT INTO Notification (NotificationID, message, urgency_level)
VALUES
    (1, 'Your course enrollment is about to expire.', 'High'),
    (2, 'New assignment available.', 'Medium'),
    (3, 'Welcome to the platform!', 'Low');
SELECT * FROM Notification;


INSERT INTO HealthCondtion (LearnerID, ProfileID, condition)
VALUES
    (1, 1, 'Color Blindness'),
    (2, 2, 'Dyslexia'),
    (3, 3, 'Anxiety');
SELECT * FROM HealthCondtion;


INSERT INTO PersonalizationProfiles (LearnerID, ProfileID, prefered_content_type, emotional_state, personality_type)
VALUES 
(1, 1, 'Videos', 'Engaged', 'Introvert'),
(2, 2, 'Quizzes', 'Motivated', 'Extrovert'),
(3, 3, 'Interactive Simulations', 'Curious', 'Analytical');
SELECT * FROM PersonalizationProfiles



INSERT INTO ContentLibrary (ID, ModuleID, CourseID, Title, description, metadata, type, content_URL)
VALUES
    (1, 1, 103, 'Variables Tutorial', 'Learn about variables and data types', 'variables, basics', 'Video', 'http://example.com/variables-video'),
    (2, 2, 104, 'SQL Basics Tutorial', 'Master SQL queries and concepts', 'SQL, basics', 'Interactive', 'http://example.com/sql-basics');
SELECT * FROM ContentLibrary;


INSERT INTO Survey (ID, Title)
VALUES
    (1, 'Learning Preferences Survey'),
    (2, 'Feedback on Course Content'),
    (3, 'Instructor Effectiveness Survey');
SELECT * FROM Survey;




INSERT INTO SurveyQuestions (SurveyID, Question)
VALUES
    (1, 'What is your preferred learning style?'),
    (1, 'How much time can you dedicate to learning daily?'),
    (2, 'Was the course content engaging?'),
    (3, 'How effective was the instructor in teaching the course?');
SELECT * FROM SurveyQuestions;



INSERT INTO FilledSurvey (SurveyID, Question, LearnerID, Answer)
VALUES
    (1, 'What is your preferred learning style?', 1, 'Visual'),
    (1, 'How much time can you dedicate to learning daily?', 1, '2 hours'),
    (2, 'Was the course content engaging?', 2, 'Yes'),
    (3, 'How effective was the instructor in teaching the course?', 3, 'Very effective');
SELECT * FROM FilledSurvey;



INSERT INTO Learning_goal (ID, status, deadline, description)
VALUES
    (1, 'Completed', '2024-06-30', 'Complete all basic modules'),
    (2, 'Pending', '2024-07-31', 'Earn a badge in advanced database skills'),
    (3, 'In Progress', '2024-08-15', 'Collaborate on a group project in Python');
SELECT * FROM Learning_goal;



INSERT INTO LearnersGoals (GoalID, LearnerID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
SELECT * FROM LearnersGoals;





INSERT INTO Quest (QuestID, difficulty_level, criteria, description, title)
VALUES
    (1, 'Easy', 'Complete 5 activities', 'Solve beginner Python challenges', 'Python Starter Quest'),
    (2, 'Medium', 'Collaborate with a team', 'Build a project with peers', 'Team Collaboration Quest'),
    (3, 'Hard', 'Achieve mastery in algorithms', 'Pass advanced algorithm tests', 'Algorithm Mastery Quest');
SELECT * FROM Quest;




INSERT INTO QuestReward (RewardID, QuestID, LearnerID, Time_earned)
VALUES
    (1, 1, 1, '2024-07-20'),
    (2, 2, 2, '2024-08-01'),
    (3, 3, 3, '2024-09-10');
SELECT * FROM QuestReward;



INSERT INTO Collaborative (QuestID, LearnerID, deadline, Max_num_participants)
VALUES
    (2, 1, 20240630, 5),
    (2, 2, 20240630, 5),
    (2, 3, 20240630, 5);
SELECT * FROM Collaborative;





INSERT INTO Skill_Mastery (QuestID, LearnerID)
VALUES
    (1, 1),
    (3, 2),
    (1, 3);
SELECT * FROM Skill_Mastery;




INSERT INTO Skill_Mastery_Skill (LearnerID, Skills)
VALUES
    (1, 'Python Basics'),
    (2, 'Data Structures'),
    (3, 'Algorithms');
SELECT * FROM Skill_Mastery_Skill;





INSERT INTO Interaction_log (LogID, activity_ID, LearnerID, Duration, action_type)
VALUES
    (1, 1, 1, 30, 'Viewed Module Content'),
    (2, 2, 2, 45, 'Completed Quiz');
SELECT * FROM Interaction_log;



INSERT INTO Ranking (LeaderboardID, LearnerID, CourseID, rank, total_points)
VALUES
(1, 1, 101, 1, 950),
(1, 2, 101, 2, 850),
(2, 3, 102, 1, 900),
(2, 1, 102, 2, 870)
select * FROM Ranking




INSERT INTO SkillProgression (ID, proficiency_level, LearnerID, skill_name, timestamp)
VALUES
    (1, 1, 1, 'Python', '2024-11-25 10:00:00'),       
    (2, 2, 1, 'Data Analysis', '2024-11-26 14:00:00'), 
    (3, 1, 2, 'Java', '2024-11-27 09:30:00'),         
    (4, 3, 3, 'Web Development', '2024-11-28 11:00:00'), 
    (5, 2, 3, 'Database Design', '2024-11-29 15:45:00'); 

    SELECT * FROM SkillProgression



    INSERT INTO LearnerDiscussion (ForumID, LearnerID, Post, time)
VALUES
    (1, 1, 'This is a great topic to start learning SQL basics.', '2024-11-25 10:30:00'),
    (1, 2, 'I found the example in the module very helpful.', '2024-11-25 11:00:00'),
    (2, 3, 'How can we implement normalization for large databases?', '2024-11-26 14:15:00'),
    (2, 1, 'Collaborating on database design has been insightful.', '2024-11-26 15:00:00'),
    (1, 3, 'Can someone explain how to optimize SELECT queries?', '2024-11-27 09:45:00');
    SELECT * FROM LearnerDiscussion

INSERT INTO Discussion_forum (forumID, ModuleID, CourseID, title, last_active, timestamp, description)
VALUES
(1, 1, 103, 'Discussion on SQL Basics', '2024-11-20', '2024-11-20 09:00:00', 'A forum to discuss SQL basics and queries'),
(2, 2, 104, 'Database Design Discussion', '2024-11-22', '2024-11-22 10:30:00', 'Discussion on the principles of database design and normalization')
SELECT * FROM Discussion_forum


INSERT INTO Learning_path (pathID, LearnerID, ProfileID, completion_status, custom_content, adaptive_rules)
VALUES
(1, 1, 1, 'In Progress', 'Beginner Content', 'Adaptive based on quiz results'),
(2, 2, 2, 'Completed', 'Database Tutorials', 'Focus on practical exercises');
SELECT * FROM Learning_path




INSERT INTO LearnersCollaboration (LearnerID, QuestID, CompletionStatus)
VALUES
    (1, 1, 'In Progress'),
    (2, 2, 'Completed');

    SELECT * FROM Collaborative


   INSERT INTO Collaborative (QuestID, LearnerID, deadline, Max_num_participants)
VALUES
    (1, 1, '2024-12-31', 5),
    (2, 2, '2024-12-31', 5);

SELECT * FROM Collaborative

INSERT INTO Instructor (InstructorID, name, latest_qualification, expertise_area, email)
VALUES
(1, 'Prof. Liam Brown', 'MSc', 'Databases', 'liam@example.com'),
(3, 'Dr. Maria Garcia', 'PhD', 'Data Structures', 'Maria@exmple.com'),
(4, 'Prof. John Smith', 'MSc', 'Algorithms', 'Jphn@exmpl.com');
SELECT * FROM Instructor




INSERT INTO Teaches (InstructorID, CourseID)
VALUES
(1, 101),
(3, 101),
(4, 102);
SELECT * FROM Teaches


INSERT INTO learning_preferences (preference, LearnerID)
VALUES
    (1, 1), 
    (2, 1),  
    (1, 2), 
    (3, 3),  
    (2, 3); 
SELECT * FROM learning_preferences;
