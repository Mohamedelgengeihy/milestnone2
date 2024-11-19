CREATE DATABASE GamifiedEduPlatform;

USE GamifiedEduPlatform;
--
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
LearnerID INT,
skill_name VARCHAR (20) ,
PRIMARY KEY(LearnerID,skill_name),
FOREIGN KEY (LearnerID) REFERENCES Learner (LearnerID) ON DELETE CASCADE ON UPDATE CASCADE,
);
--Table for multivalue learningPreferences in learner
CREATE TABLE learning_preferences (
Skill INT,
LearnerID INT,
PRIMARY KEY(Skill, LearnerID),
FOREIGN KEY (LearnerID) REFERENCES Learner (LearnerID) ON DELETE CASCADE ON UPDATE CASCADE,
);
--Table for sorting skillprogressions 
CREATE TABLE SkillProgression (
    ID INT PRIMARY KEY,
    proficiency_level INT,
    LearnerID INT,
    skill_name VARCHAR(100),
    timestamp DATETIME,
    --FOREIGN KEY (LearnerID, skill_name) REFERENCES Skills(LearnerID, skill)
FOREIGN KEY (LearnerID, skill_name) REFERENCES skills (LearnerID, skill_name) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);



--Table for storing personalization profiles
CREATE TABLE PersonalizationProfiles(
LearnerID INT,
ProfileID INT,
prefered_content_type VARCHAR (100),
emotional_state VARCHAR (50),
personality_type VARCHAR (100),
PRIMARY KEY (LearnerID, ProfileID),
FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)

);

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
 
 --table Discussionforums
 CREATE TABLE Discussion_forum(
forumID INT PRIMARY KEY,
ModuleID INT,
CourseID INT,
title VARCHAR(50),
last_active VARCHAR(50),
timestamp DATETIME,
description VARCHAR, 

FOREIGN KEY (ModuleID) REFERENCES Module(ModuleID),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
 );



-- Table for storing assessments and grades
CREATE TABLE Assessment (
    AssessmentID INT PRIMARY KEY, 
    total_marks INT,
    CourseID INT,
    ModuleID INT,
    passing_marks INT,
    criteria VARCHAR(50),
    weightage INT,
    Type VARCHAR (100) ,
    Title VARCHAR (50),
    description VARCHAR (1000),
    FOREIGN KEY (CourseID)REFERENCES course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE,  
    FOREIGN KEY (ModuleID)REFERENCES Module (ModuleID) ON DELETE CASCADE ON UPDATE CASCADE, 
);

-- Table for storing modules within a course
CREATE TABLE Module (
    ModuleID INT,
    CourseID INT,
    Title VARCHAR(100),
    difficulty_Level VARCHAR(50),
    contentURL VARCHAR (1000),
        PRIMARY KEY (ModuleID, CourseID),

    FOREIGN KEY (CourseID)REFERENCES Course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE,  

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
    FOREIGN KEY (ModuleID) REFERENCES Module(ModuleID),
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
    FOREIGN KEY (ModuleID) REFERENCES Module(ModuleID),
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
    FOREIGN KEY (ModuleID) REFERENCES Module(ModuleID),
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
    FOREIGN KEY (FeedbackID) REFERENCES EmotionalFeedback(FeedbackID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
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
    LeaderboardID INT,
    LearnerID INT,
    CourseID INT,
    rank INT,
    total_points INT,
    PRIMARY KEY (LeaderboardID, LearnerID, CourseID),
    FOREIGN KEY (LeaderboardID) REFERENCES Leaderboard(LeaderboardID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


-- Table for storing leaderboard information
CREATE TABLE Leaderboard (
    LeaderboardID INT PRIMARY KEY,
    season VARCHAR (20),

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
--collaborative table
CREATE TABLE Collaborative (
    QuestID INT,
    LearnerID INT,
    deadline INT,
    Max_num_participants INT,
    PRIMARY KEY (QuestID, LearnerID),
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
--many-2-many relationship between Collaborative and Learner
CREATE TABLE Joins(
    LearnerID INT,
    deadline INT,
    Max_num_participants INT,
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (deadline) REFERENCES Collaborative(deadline),
    FOREIGN KEY (Max_num_participants) REFERENCES Collaborative(Max_num_participants)

);
--skill_mastery table
CREATE TABLE skill_Mastery(
    QuestID INT,
    LearnerID INT,

    PRIMARY KEY (QuestID, LearnerID),
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);

--multivalued attribute in skill mastery
 CREATE TABLE Skill_Mastery_Skill (
    LearnerID INT,
    Skills VARCHAR(255),
    PRIMARY KEY (LearnerID, Skills),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);



--many-2-many relationship between Skill_mastery and Learner
CREATE TABLE Joins (
    LearnerID INT,
    Skills VARCHAR(255),
    CourseID INT,
    completionstatus VARCHAR(50),
    PRIMARY KEY (LearnerID, Skills),
    FOREIGN KEY (LearnerID, Skills) REFERENCES Skill_Mastery_Skill (LearnerID, Skills),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


--Disjoint between Skill_Mastery and Collaborative
GO
CREATE TRIGGER Disjoint

ON Skill_Mastery
INSTEAD OF INSERT
AS
BEGIN
    -- Check if any QuestID in the inserted data already exists in the Collaborative table
    IF EXISTS (
        SELECT 1
        FROM Inserted i
        JOIN Collaborative c ON i.QuestID = c.QuestID
    )
    BEGIN
        -- Raise an error if the QuestID is already in Collaborative
        RAISERROR ('A Quest cannot be both a Skill_Mastery and a Collaborative.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;  
    END;
  
    -- If no conflict, proceed with the insert
    INSERT INTO Skill_Mastery (QuestID, LearnerID)
    SELECT QuestID, LearnerID
    FROM Inserted;
END;














--Retrieve all the information for any student using their ID
GO
CREATE PROCEDURE ViewInfo(
@LearnerID INT
)
AS
BEGIN
SELECT * FROM Learners
WHERE LearnerID = @LearnerID;
END;
GO

--Retrieve all the information from all the profiles of a certain learner
CREATE PROCEDURE LearnerInfo(@LearnerID INT)
AS
BEGIN
SELECT * FROM LearnerProfiles
WHERE LearnerID = @LearnerID;
END;

--Retrieve the latest emotional state of a learner
GO
CREATE PROCEDURE EmotionalState(
@LearnerID INT,@emotional_state VARCHAR(50) OUTPUT
)
    
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
END;
GO

-- 4) View the latest interaction logs for a certain Learner
CREATE PROCEDURE LogDetails (@LearnerID INT)
AS
BEGIN
    SELECT * FROM InteractionLogs
    WHERE LearnerID = @LearnerID ORDER BY Timestamp DESC;
    END;


    --View all the Emotional feedbacks that a certain Instructor reviewed
    GO
CREATE PROCEDURE InstructorReview (
@InstructorID INT
)
AS
BEGIN
SELECT *
FROM EmotionalFeedback_review
WHERE InstuctorId = @InstructorID AND Reviewed = 1;
END;
GO

--Delete a course from the database when it's no longer being taught
CREATE PROCEDURE CourseRemove (@CourseID INT)
AS
BEGIN
    DELETE FROM Courses
    WHERE CourseID = @CourseID;
END;

--View the assessment with the highest Maximum points for each course
GO
CREATE PROCEDURE HighestGrade
AS
  BEGIN 
    SELECT CourseID, MAX(MaxPoints) AS HighestPoints 
    FROM Assessment
    GROUP BY CourseID;
    END;
    GO
--View all the courses taught by more than one instructor
CREATE PROCEDURE InstructorCount
AS
BEGIN 
    SELECT CourseID, COUNT(InstructorID) AS IntsructorCount
    FROM CourseInstructors
    GROUP BY CourseID
    HAVING COUNT(InstructorID) > 1;
    END;

 --View all the notifications sent to a certain Learner
 GO
CREATE PROCEDURE ViewNot(
@LearnerID INT
)
AS
BEGIN 
    SELECT * FROM Notification
    WHERE LearnerID = @LearnerID;
    END;
    GO

    --Create a new discussion forum for a given module
    GO
    CREATE PROCEDURE CreateDiscussion(@ModuleID INT, @CourseID INT, @Title VARCHAR(50), @Description VARCHAR(50))
    AS 
    BEGIN
        INSERT INTO DiscussionForums (ModuleID, CourseID, Title, Description)
        VALUES (@ModuleID, @CourseID, @Title, @Description);
        END;
        GO
   --Remove a certain badge from the database
CREATE PROCEDURE RemoveBadge(
@BadgeID INT
)
AS
BEGIN
    DELETE FROM Badges WHERE BadgeID = @BadgeID;
END;

--Delete all the available quests that belong to a certain criterion
GO
CREATE PROCEDURE CriteriaDelete(@Criteria VARCHAR(50))
AS
BEGIN
    DELETE FROM Quests WHERE Criteria = @Criteria;
END;
GO
--Mark notifications as read or delete them
CREATE PROCEDURE NotificationUpdate
(@LearnerID INT, 
@NotificationID INT, 
@ReadStatus BIT
)
AS
BEGIN
    UPDATE Notifications SET ReadStatus = @ReadStatus WHERE LearnerID = @LearnerID AND NotificationID = @NotificationID;
END;

--View emotional feedback trends over time for each learner
CREATE PROCEDURE EmotionalTrendAnalysis(
@CourseID INT, 
@ModuleID INT,
@TimePeriod VARCHAR(50)
)
AS
BEGIN
    SELECT LearnerID, EmotionalState, COUNT(*) 
    AS FeedbackCount 
    FROM LearnerEmotions
    WHERE CourseID = @CourseID AND ModuleID = @ModuleID AND Timestamp > DATEADD(MONTH, -CAST(@TimePeriod AS INT), GETDATE())
    GROUP BY LearnerID, EmotionalState;
END;


--Update my profile with new details
CREATE PROCEDURE ProfileUpdate(@LearnerID INT, @ProfileID INT, @PreferredContentType VARCHAR(50), @EmotionalState VARCHAR(50), @PersonalityType VARCHAR(50))
AS
BEGIN
    UPDATE LearnerProfiles SET PreferredContentType = @PreferredContentType, EmotionalState = @EmotionalState, PersonalityType = @PersonalityType WHERE LearnerID = @LearnerID AND ProfileID = @ProfileID;
END;

--Calculate the total points I earned from the rewards
CREATE PROCEDURE TotalPoints(@LearnerID INT, @RewardType VARCHAR(50))
AS
BEGIN
    SELECT SUM(Points) AS TotalPoints FROM Rewards WHERE LearnerID = @LearnerID AND RewardType = @RewardType;
END;

--Display all the courses I am currently enrolled in
CREATE PROCEDURE EnrolledCourses(@LearnerID INT)
AS
BEGIN
    SELECT * FROM Courses WHERE LearnerID = @LearnerID;
END;

--Check if I have completed all the prerequisites for a certain course
CREATE PROCEDURE Prerequisites(@LearnerID INT, @CourseID INT)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Prerequisites WHERE LearnerID = @LearnerID AND CourseID = @CourseID)
        PRINT 'Prerequisites not completed';
    ELSE
        PRINT 'Prerequisites completed';
END;

--View all the Modules for a certain course that trains certain traits I specify
CREATE PROCEDURE ModuleTraits(@TargetTrait VARCHAR(50), @CourseID INT)
AS
BEGIN
    SELECT * FROM Modules WHERE CourseID = @CourseID AND Traits LIKE '%' + @TargetTrait + '%';
END;

--View All the participants in a leaderboard and their ranking
CREATE PROCEDURE LeaderboardRank(@LeaderboardID INT)
AS
BEGIN
    SELECT LearnerID, Rank FROM Leaderboards WHERE LeaderboardID = @LeaderboardID;
END;

--Submit an emotional feedback to a certain activity
CREATE PROCEDURE ViewMyDeviceCharge(@ActivityID INT, @LearnerID INT, @Timestamp DATETIME, @EmotionalState VARCHAR(50))
AS
BEGIN
    INSERT INTO EmotionalFeedbacks (ActivityID, LearnerID, Timestamp, EmotionalState) VALUES (@ActivityID, @LearnerID, @Timestamp, @EmotionalState);
END;

--Join a collaborative quest if space is available
CREATE PROCEDURE JoinQuest(@LearnerID INT, @QuestID INT)
AS
BEGIN
    DECLARE @MaxParticipants INT, @CurrentParticipants INT;
    SELECT @MaxParticipants = MaxParticipants, @CurrentParticipants = (SELECT COUNT(*) FROM QuestParticipants WHERE QuestID = @QuestID) FROM Quests WHERE QuestID = @QuestID;

    IF @CurrentParticipants < @MaxParticipants
    BEGIN
        INSERT INTO QuestParticipants (LearnerID, QuestID) VALUES (@LearnerID, @QuestID);
        PRINT 'Joined the quest successfully';
    END
    ELSE
    BEGIN
        PRINT 'Quest is full';
    END;
END;

--View my skills proficiency level
CREATE PROCEDURE SkillsProficiency(@LearnerID INT)
AS
BEGIN
    SELECT Skill, ProficiencyLevel FROM LearnerSkills WHERE LearnerID = @LearnerID;
END;

--View my score for a certain assessment
CREATE PROCEDURE ViewScore(@LearnerID INT, @AssessmentID INT)
AS
BEGIN
    SELECT Score FROM Assessments WHERE LearnerID = @LearnerID AND AssessmentID = @AssessmentID;
END;

--View all the assessments I took and its grades for a certain module
CREATE PROCEDURE AssessmentsList(@CourseID INT, @ModuleID INT)
AS
BEGIN
    SELECT * FROM Assessments WHERE CourseID = @CourseID AND ModuleID = @ModuleID;
END;

--Register in any course I want as long as I completed its prerequisites
CREATE PROCEDURE CourseRegister(@LearnerID INT, @CourseID INT)
AS
BEGIN
    IF EXISTS (SELECT * FROM Prerequisites WHERE LearnerID = @LearnerID AND CourseID = @CourseID)
    BEGIN
        INSERT INTO Enrollments (LearnerID, CourseID) VALUES (@LearnerID, @CourseID);
        PRINT 'Registration successful';
    END
    ELSE
    BEGIN
        PRINT 'Prerequisites not completed';
    END;
END;

--List all the learners that have a certain skill
CREATE PROCEDURE SkillLearners 
    @Skillname VARCHAR(50)
AS
BEGIN
    SELECT LearnerID, LearnerName
    FROM Learners
    WHERE Skill = @Skillname;
END;

--Add new Learning activities for a course module
CREATE PROCEDURE NewActivity
    @CourseID INT, 
    @ModuleID INT, 
    @activitytype VARCHAR(50), 
    @instructiondetails VARCHAR(MAX), 
    @maxpoints INT
AS
BEGIN
    INSERT INTO Activities (CourseID, ModuleID, ActivityType, InstructionDetails, MaxPoints)
    VALUES (@CourseID, @ModuleID, @activitytype, @instructiondetails, @maxpoints);
END;

--Award a new achievement to a learner
CREATE PROCEDURE NewAchievement
    @LearnerID INT, 
    @BadgeID INT, 
    @description VARCHAR(MAX), 
    @date_earned DATE, 
    @type VARCHAR(50)
AS
BEGIN
    INSERT INTO Achievements (LearnerID, BadgeID, Description, DateEarned, Type)
    VALUES (@LearnerID, @BadgeID, @description, @date_earned, @type);
END;

--View all the learners who earned a certain badge
CREATE PROCEDURE LearnerBadge
    @BadgeID INT
AS
BEGIN
    SELECT LearnerID, LearnerName
    FROM Learners
    WHERE LearnerID IN (SELECT LearnerID FROM Achievements WHERE BadgeID = @BadgeID);
END;

--Add a new learning path for a learner
CREATE PROCEDURE NewPath
    @LearnerID INT, 
    @ProfileID INT, 
    @completion_status VARCHAR(50), 
    @custom_content VARCHAR(MAX), 
    @adaptiverules VARCHAR(MAX)
AS
BEGIN
    INSERT INTO LearningPaths (LearnerID, ProfileID, CompletionStatus, CustomContent, AdaptiveRules)
    VALUES (@LearnerID, @ProfileID, @completion_status, @custom_content, @adaptiverules);
END;

--View all the courses that a learner took so far
CREATE PROCEDURE TakenCourses
    @LearnerID INT
AS
BEGIN
    SELECT CourseID, CourseName
    FROM Courses
    WHERE CourseID IN (SELECT CourseID FROM Enrollments WHERE LearnerID = @LearnerID);
END;

--Add a new collaborative Quest
CREATE PROCEDURE CollaborativeQuest
    @difficulty_level VARCHAR(50), 
    @criteria VARCHAR(50), 
    @description VARCHAR(50), 
    @title VARCHAR(50), 
    @Maxnumparticipants INT, 
    @deadline DATETIME
AS
BEGIN
    INSERT INTO Quests (DifficultyLevel, Criteria, Description, Title, MaxNumParticipants, Deadline)
    VALUES (@difficulty_level, @criteria, @description, @title, @Maxnumparticipants, @deadline);
END;

/*
--Create an inventory for a specific item
CREATE PROCEDURE Sp_Inventory
    @item_id INT,
    @name VARCHAR(30),
    @quantity INT,
    @expirydate DATETIME,
    @price DECIMAL(10,2),
    @manufacturer VARCHAR(30),
    @category VARCHAR(20)
AS
BEGIN
    INSERT INTO Inventory (ItemID, ItemName, Quantity, ExpiryDate, Price, Manufacturer, Category)
    VALUES (@item_id, @name, @quantity, @expirydate, @price, @manufacturer, @category);
END;
*/

    --update the deadline of a quest
CREATE PROCEDURE DeadlineUpdate
    @QuestID INT,
    @deadline DATETIME
AS
BEGIN
    UPDATE Quests 
    SET Deadline = @deadline
    WHERE QuestID = @QuestID;
END

-- Update an assessment grade for a learner
CREATE PROCEDURE GradeUpdate(
@LearnerID INT,
@AssessmentID INT,
@NewGrade INT
)
AS
BEGIN
UPDATE AssessmentResults
SET Score = @NewGrade
WHERE LearnerID = @LearnerID AND AssessmentID = @AssessmentID;
END;

--Send a notification to a learner about an upcoming assessment deadline
CREATE PROCEDURE AssessmentNot
    @NotificationID INT,
    @timestamp TIMESTAMP,
    @message VARCHAR(MAX),
    @urgencyLevel VARCHAR(50),
    @LearnerID INT
AS
BEGIN
    INSERT INTO Notification (ID, timestamp, message, urgency_level)
    VALUES (@NotificationID, @timestamp, @message, @urgencyLevel);

    INSERT INTO ReceivedNotification (NotificationID, LearnerID)
    VALUES (@NotificationID, @LearnerID);

    PRINT 'Notification sent successfully.';
END

--Define new learning goals for the learners
CREATE PROCEDURE NewGoal(
@GoalID INT,
    @Status VARCHAR(MAX),
    @Deadline DATETIME,
    @Description VARCHAR(MAX)
)
AS 
BEGIN
INSERT INTO LearningGoals (GoalID, Status, Deadline, Description)
    VALUES (@GoalID, @Status, @Deadline, @Description);
END;

--List all the learners enrolled in the courses I teach
CREATE PROCEDURE LearnersCoutrses(
@CourseID INT,
@InstructorID INT
)
AS
BEGIN
SELECT LearnerID, Name
    FROM Enrollment
    JOIN Learner ON Enrollment.LearnerID = Learner.LearnerID
    WHERE CourseID = CourseID AND InstructorID = InstructorID;
END;

--See the last time a discussion forum was active
CREATE PROCEDURE LastActive(
@ForumID INT
)
AS
BEGIN
SELECT MAX(Timestamp) AS LastActive
FROM ForumPosts
WHERE DiscussionID = @ForumID;
END;

--Find the most common emotional state for the learners

CREATE PROCEDURE CommonEmotionalState (
@state VARCHAR(50) OUTPUT
)
AS
BEGIN
SELECT TOP 1 EmotionalState --retrieves the most frequent emotional state
FROM EmotionalFeedback
GROUP BY EmotionalState
ORDER BY COUNT(*) DESC;
END;

--view all modules for a certain course sorted by their diffiulty
CREATE PROCEDURE ModuleDifficulty(
@CourseID INT
)
AS
BEGIN
SELECT *
FROM Module
WHERE CourseID = @CourseID 
ORDER BY difficulty_Level ASC;
END;


--View the skill with the highest proficiency level for a certain learner
CREATE PROCEDURE ProficiencyLevel(
@LearnerID INT
)
AS 
BEGIN
    SELECT TOP 1 SkillName, ProficiencyLevel
    FROM LearnerSkills
    WHERE LearnerID = @LearnerID
    ORDER BY ProficiencyLevel DESC;
    END;

    --Update a learner proficiency level for a certain skill
    CREATE PROCEDURE ProficiencyUpdate(
    @SkillName VARCHAR(50),
    @LearnerID INT,
    @Level VARCHAR(50)
    )
    AS
    BEGIN 
    UPDATE LearnerSkills
    SET ProficiencyLevel = @Level
    WHERE SkillName = @SkillName AND LearnerID = @LearnerID;
    END;

    --find the learner with the least number of badges earned
    CREATE PROCEDURE LeastBadge(
    @LearnerID INT
    )
    AS
    BEGIN 
        SELECT TOP 1 LearnerID 
        FROM Achievement
        GROUP BY LearnerID
        ORDER BY COUNT(BadgeID) ASC;
        END;

        --find the most preferred learning type for the learners
        CREATE PROCEDURE PreferredType(
        @Type VARCHAR(50) 
        )

        AS
        BEGIN
            SELECT TOP 1 PreferredContetntType
            FROM LearnerProfiles
            GROUP BY PreferredContentType
            ORDER BY COUNT(*) DESC;
            END;

        --Generate analytics on assessment scores across modules or courses
        CREATE PROCEDURE AssessmentAnalytics (
        @CourseID INT,
        @ModuleID INT
)
        AS
        BEGIN
            SELECT AVG(Score) AS AverageScore, ModuleID, CourseID
            FROM AssessmentResults ar
            INNER JOIN Assessments a ON ar.AssessmentID = a.AssessmentID
            WHERE a.CourseID = @CourseID AND a.ModuleID = @ModuleID
            GROUP BY ModuleID, CourseID;
        END;

        --View trends in learners’ emotional feedback to support well-being
        CREATE PROCEDURE EmotionalTrendAnalysis (
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod VARCHAR(50)
)
AS
BEGIN
    SELECT EmotionalState, COUNT(*) AS Frequency, Timestamp
    FROM EmotionalFeedback ef
    INNER JOIN Enrollments e ON ef.LearnerID = e.LearnerID
    WHERE e.CourseID = @CourseID AND e.ModuleID = @ModuleID
    GROUP BY EmotionalState, Timestamp
    ORDER BY Timestamp ASC;
END;
