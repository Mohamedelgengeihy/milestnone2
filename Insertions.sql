USE GamifiedEduPlatform;

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
