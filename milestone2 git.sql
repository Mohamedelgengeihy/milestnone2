﻿CREATE DATABASE GamifiedEduPlatform;
milestone
USE GamifiedEduPlatform;

-- Table for storing learner information
CREATE TABLE Learner (
    LearnerID INT PRIMARY KEY,
    first_name VARCHAR (50),
    last_name VARCHAR(50),
    Preferred_content_type VARCHAR(50),
    Gender VARCHAR (20),
    birth_date datetime,
    country VARCHAR (50),
    cultural_background VARCHAR (100),
    

);

--Table for multivalue skills in learner
CREATE TABLE skills(
PRIMARY KEY(Skill, LearnerID),
Skill VARCHAR (20) ,
FOREIGN KEY (LearnerID) REFERENCES Learner (LearnerID) ON DELETE CASCADE ON UPDATE CASCADE,
);
--Table for multivalue learningPreferences in learner
CREATE TABLE learningpreferences(
PRIMARY KEY(Skill, LearnerID),
FOREIGN KEY (LearnerID) REFERENCES Learner (LearnerID) ON DELETE CASCADE ON UPDATE CASCADE,
);
--Table for sorting skillprogressions 
CREATE TABLE SkillProgression (
    ID INT PRIMARY KEY,
    proficiency_level INT,
    LearnerID INT,
    skill_name VARCHAR(100),
    // timestamp DATETIME,
    FOREIGN KEY (LearnerID, skill_name) REFERENCES Skills(LearnerID, skill)
);

--Table to show relations of learners and skills
CREATE TABLE learnerskills(
LearnerID INT PRIMARY KEY,

FOREIGN KEY (ProfileID) REFERENCES PersonalizationProfiles (ProfileID) ON DELETE CASCADE ON UPDATE CASCADE,,


-- Table for storing courses
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(100),
    Learning_objectives VARCHAR (100),
    credit_points int,
    difficulty_level VARCHAR (100),
    description VARCHAR (50),
    Pre_requisites VARCHAR (50),
);
 

-- Table for storing assessments and grades
CREATE TABLE Assessment (
    AssessmentID INT PRIMARY KEY,
    FOREIGN KEY (CourseID)REFERENCES course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE,  
    FOREIGN KEY (ModuleID)REFERENCES Module (ModuleID) ON DELETE CASCADE ON UPDATE CASCADE,  
    total_marks INT,
    passing_marks INT,
    criteria VARCHAR(50),
    weightage INT,
    Type VARCHAR (100) ,
    Title VARCHAR (50),
    description VARCHAR (1000),
);

-- Table for storing modules within a course
CREATE TABLE Module (
    ModuleID INT PRIMARY KEY,
    FOREIGN KEY (CourseID)REFERENCES course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE,  
    Title VARCHAR(100),
    difficulty_Level VARCHAR(50),
    contentURL VARCHAR (1000),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

--multivalued Attribute in Module
CREATE TABLE Target_traits (
    ModuleID INT,
    CourseID INT,
    Trait VARCHAR(50),
    PRIMARY KEY (ModuleID, CourseID, Trait),
    FOREIGN KEY (ModuleID) REFERENCES Modules(ModuleID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
--multivalued Attribute in Module
CREATE TABLE ModuleContent (
    ModuleID INT,
    CourseID INT,
    content_type VARCHAR(50),
    PRIMARY KEY (ModuleID, CourseID, content_type),
    FOREIGN KEY (ModuleID) REFERENCES Modules(ModuleID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);



-- Table for storing badges
CREATE TABLE Badge (
    BadgeID INT PRIMARY KEY,
    title VARCHAR(50),
    criteria VARCHAR (20),
    points INT,
    Description VARCHAR(100),
);

-- Table for storing emotional feedback by learners
CREATE TABLE EmotionalFeedback (
    FeedbackID INT PRIMARY KEY,
    LearnerID INT,
    timestamp DATETIME,
    emotionalState VARCHAR(50),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID) ON DELETE CASCADE ON UPDATE CASCADE,

);

-- Table for storing leaderboard information
CREATE TABLE Leaderboard (
    LeaderboardID INT PRIMARY KEY,
    season VARCHAR (20),

);
--Table for storing personalization profiles
CREATE TABLE PersonalizationProfiles(
LearnerID INT,
ProfileID INT PRIMARY KEY,
prefered_content_type VARCHAR (100),
emotional_state VARCHAR (50),
personality_type VARCHAR (100),
PRIMARY KEY (LearnerID, ProfileID),
FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)

);

--multivalued Attribute in PersonalizationProfiles
CREATE TABLE HealthCondtion (
LearnerID INT,
    ProfileID INT,
    condition VARCHAR(100),
    PRIMARY KEY (LearnerID, ProfileID, condition),
    FOREIGN KEY (LearnerID, ProfileID) REFERENCES PersonalizationProfiles(LearnerID, ProfileID)
);


-- Creating ContentLibrary Table
CREATE TABLE ContentLibrary (
    ID INT PRIMARY KEY,
    ModuleID INT,
    CourseID INT,
    Title VARCHAR(100),
    description VARCHAR(255),
    metadata VARCHAR(255),
    type VARCHAR(50),
    content_URL VARCHAR(255),
    FOREIGN KEY (ModuleID) REFERENCES Modules(ModuleID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
-- Creating Learning_activities Table
CREATE TABLE Learning_activities (
    ActivityID INT PRIMARY KEY,
    ModuleID INT,
    CourseID INT,
    activity_type VARCHAR(50),
    instruction_details VARCHAR(255),
    Max_points INT,
    FOREIGN KEY (ModuleID) REFERENCES Modules(ModuleID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Creating Learning_path Table
CREATE TABLE Learning_path (
    pathID INT PRIMARY KEY,
    LearnerID INT,
    ProfileID INT,
    completion_status VARCHAR(50),
    custom_content VARCHAR(255),
    adaptive_rules VARCHAR(255),
    FOREIGN KEY (LearnerID, ProfileID) REFERENCES PersonalizationProfiles(LearnerID, ProfileID)
);



-- Creating Interaction_log Table
CREATE TABLE Interaction_log (
    LogID INT PRIMARY KEY,
    activity_ID INT,
    LearnerID INT,
    Duration TIME,
    Timestamp TIMESTAMP,
    action_type VARCHAR(50),
    FOREIGN KEY (activity_ID) REFERENCES Learning_activities(ActivityID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
-- Creating Instructor Table
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    name VARCHAR(100),
    latest_qualification VARCHAR(50),
    expertise_area VARCHAR(100),
    email VARCHAR(100)
);

--many-2-many relationship between instructors and LearningPath
CREATE TABLE Pathreview (
    InstructorID INT,
    PathID INT,
    feedback VARCHAR(255),
    PRIMARY KEY (InstructorID, PathID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
    FOREIGN KEY (PathID) REFERENCES Learning_path(pathID)
);


--many-2-many relationship between instructors and EmotionalFeedback

CREATE TABLE Emotionalfeedback_review (
    FeedbackID INT,
    InstructorID INT,
    feedback VARCHAR(255),
    PRIMARY KEY (FeedbackID, InstructorID),
    FOREIGN KEY (FeedbackID) REFERENCES Emotional_feedback(FeedbackID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

--Table for relationship between personalization profiles and learner
CREATE TABLE LearnerProfile (
ProfileID INT,
LearnerID INT,
PRIMARY KEY (ProfileID , LearnerID),
FOREIGN KEY (ProfileID) REFERENCES PersonalizationProfiles (ProfileID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (LearnerID) REFERENCES Learner (LearnerID)ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE Course_enrollment (
    EnrollmentID INT PRIMARY KEY,
    CourseID INT,
    LearnerID INT,
    completion_date DATE,
    enrollment_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);

--many-2-many relation between instructor and course
CREATE TABLE Teaches (
    InstructorID INT,
    CourseID INT,
    PRIMARY KEY (InstructorID, CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
--many-2-many relation between learners and Leaderboard
CREATE TABLE Ranking (
    BoardID INT,
    LearnerID INT,
    CourseID INT,
    rank INT,
    total_points INT,
    PRIMARY KEY (BoardID, LearnerID, CourseID),
    FOREIGN KEY (BoardID) REFERENCES Leaderboard(BoardID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
--LearningGoal table
CREATE TABLE Learning_goal (
    ID INT PRIMARY KEY,
    status VARCHAR(50),
    deadline DATE,
    description VARCHAR(255)
);

--many-2-many relation between Learning_goal and Learner
CREATE TABLE LearnersGoals (
    GoalID INT,
    LearnerID INT,
    PRIMARY KEY (GoalID, LearnerID),
    FOREIGN KEY (GoalID) REFERENCES Learning_goal(ID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
--Survey Table
CREATE TABLE Survey (
    ID INT PRIMARY KEY,
    Title VARCHAR(100)
);
--multivalued attribute
CREATE TABLE SurveyQuestions (
    SurveyID INT,
    Question VARCHAR(255),
    PRIMARY KEY (SurveyID, Question),
    FOREIGN KEY (SurveyID) REFERENCES Survey(ID)
);
--many-2-many relation between surveys and learners HAS ANSWERS multivalued attribute
CREATE TABLE FilledSurvey (
    SurveyID INT,
    Question VARCHAR(255),
    LearnerID INT,
    Answer VARCHAR(255),
    PRIMARY KEY (SurveyID, Question, LearnerID),
    FOREIGN KEY (SurveyID, Question) REFERENCES SurveyQuestions(SurveyID, Question),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);

--Notifications Table 
CREATE TABLE Notification (
    ID INT PRIMARY KEY,
    timestamp TIMESTAMP,
    message VARCHAR(255),
    urgency_level VARCHAR(50)
);
--many-2-many relation between notification and learners
CREATE TABLE ReceivedNotification (
    NotificationID INT,
    LearnerID INT,
    PRIMARY KEY (NotificationID, LearnerID),
    FOREIGN KEY (NotificationID) REFERENCES Notification(ID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);

--Acheivments Table
CREATE TABLE Achievement (
    AchievementID INT PRIMARY KEY,
    LearnerID INT,
    BadgeID INT,
    description VARCHAR(255),
    date_earned DATE,
    type VARCHAR(50),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (BadgeID) REFERENCES Badge(BadgeID)
);

CREATE TABLE Reward (
    RewardID INT PRIMARY KEY,
    value DECIMAL(10,2),
    description VARCHAR(255),
    type VARCHAR(50)
);
--Quest Table
CREATE TABLE Quest (
    QuestID INT PRIMARY KEY,
    difficulty_level VARCHAR(50),
    criteria VARCHAR(50),
    description VARCHAR(255),
    title VARCHAR(50)
);

CREATE TABLE Collaborative (
    QuestID INT,
    LearnerID INT,
    PRIMARY KEY (QuestID, LearnerID),
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);




CREATE PROCEDURE ViewInfo
@LearnerID INT
AS
SELECT * FROM Learners
WHERE LearnerID = @LearnerID


CREATE PROCEDURE LearnerInfo
@LearnerID INT
AS
SELECT * FROM LearnerProfiles
WHERE LearnerID = @LearnerID


CREATE PROCEDURE EmotionalState
    @LearnerID INT,
    @emotional_state VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT @emotional_state = EmotionalState
    FROM LearnerEmotions
    WHERE LearnerID = @LearnerID
    AND Timestamp = (
        SELECT MAX(Timestamp)
        FROM LearnerEmotions
        WHERE LearnerID = @LearnerID
    );
END

CREATE PROCEDURE LogDetails
@LearnerID INT
AS
SELECT * FROM InteractionLogs
WHERE LearnerID = @LearnerID


CREATE PROCEDURE InstructorReview
@InstructorID INT
AS
SELECT feedback
FROM EmotionalFeedback_review
WHERE InstuctorId = @InstructorID


CREATE PROCEDURE CourseRemove
    @CourseID INT
AS
BEGIN
    DELETE FROM Courses
    WHERE CourseID = @CourseID;
END
