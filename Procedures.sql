CREATE DATABASE GamifiedEduPlatform;

USE GamifiedEduPlatform;
--
--Retrieve all the information for any student using their ID
GO
CREATE PROCEDURE ViewInfo(
@LearnerID INT
)
AS
BEGIN
SELECT * FROM Learner
WHERE LearnerID = @LearnerID;
END;
DROP PROCEDURE ViewInfo;
GO
EXEC ViewInfo @LearnerID = 1;

--Retrieve all the information from all the profiles of a certain learner
CREATE PROCEDURE LearnerInfo(@LearnerID INT)
AS
BEGIN
SELECT * FROM PersonalizationProfiles
WHERE LearnerID = @LearnerID;
END;
DROP PROCEDURE LearnerInfo
EXEC LearnerInfo @LearnerID = 1;

--Retrieve the latest emotional state of a learner
GO
CREATE PROCEDURE EmotionalState
@LearnerID INT
AS
BEGIN
    SELECT EmotionalState
    FROM EmotionalFeedback
    WHERE LearnerID = @LearnerID
END;
DROP Procedure EmotionalState

EXEC EmotionalState @LearnerID = 1;



-- 4) View the latest interaction logs for a certain Learner
GO
CREATE PROCEDURE LogDetails (@LearnerID INT)
AS
BEGIN
    SELECT LogID 
    FROM Interaction_log
    WHERE LearnerID = @LearnerID ;
    END;
    DROP PROC LogDetails
EXEC LogDetails @LearnerID = 1;

    --View all the Emotional feedbacks that a certain Instructor reviewed
    GO
CREATE PROCEDURE InstructorReview (
@InstructorID INT
)
AS
BEGIN
SELECT feedback
FROM EmotionalFeedback_review
WHERE InstructorID = @InstructorID;
END;
exec InstructorReview @InstructorID = 1
DROP PROCEDURE InstructorReview


--Delete a course from the database when it's no longer being taught
GO
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
CREATE PROCEDURE EmotionalTrendAnalysis
@CourseID INT, 
@ModuleID INT,
@TimePeriod VARCHAR(50)

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
    SELECT Score
    FROM Assessments
    WHERE LearnerID = @LearnerID AND AssessmentID = @AssessmentID;
END;

--View all the assessments I took and its grades for a certain module
CREATE PROCEDURE AssessmentsList(@CourseID INT, @ModuleID INT)
AS
BEGIN
    SELECT * FROM Assessments WHERE CourseID = @CourseID AND ModuleID = @ModuleID;
END;


---
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
