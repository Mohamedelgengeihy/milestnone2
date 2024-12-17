USE GENGO;



-- Stored Procedure: Delete Learner's Personalization Profile
GO
CREATE PROCEDURE DeletePersonalizationProfile
    @LearnerID INT
AS
BEGIN
    DELETE FROM PersonalizationProfiles
    WHERE LearnerID = @LearnerID;
END;




GO
CREATE PROCEDURE RegisterUser
    @Email NVARCHAR(255),
    @Password NVARCHAR(255),
    @FullName NVARCHAR(255),
    @UserType NVARCHAR(50)
AS
BEGIN
    -- Insert a new user into the Users table
    INSERT INTO Users (email, password, full_name, user_type, created_at, updated_at)
    VALUES (@Email, @Password, @FullName, @UserType, GETDATE(), GETDATE());

    -- Fetch and return the user profile
    SELECT username AS Id, full_name AS Name, email, user_type AS Role
    FROM Users
    WHERE email = @Email;
END;




GO
CREATE PROCEDURE DeleteInstructorAccount
    @AdminID INT,
    @InstructorID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE username = @AdminID AND user_type = 'Admin')
    BEGIN
        DELETE FROM Users
        WHERE username = @InstructorID AND user_type = 'Instructor';

        PRINT 'Instructor account deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Only admins can delete instructor accounts.';
    END
END;

GO
CREATE PROCEDURE DeleteLearnerAccount
    @AdminID INT,
    @LearnerID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE username = @AdminID AND user_type = 'Admin')
    BEGIN
        -- Delete related data in other tables
        DELETE FROM ReceivedNotification WHERE LearnerID = @LearnerID;
        DELETE FROM Course_enrollment WHERE LearnerID = @LearnerID;
        DELETE FROM PersonalizationProfiles WHERE LearnerID = @LearnerID;
        DELETE FROM Learning_path WHERE LearnerID = @LearnerID;

        -- Delete learner from Users table
        DELETE FROM Users WHERE username = @LearnerID AND user_type = 'Learner';

        PRINT 'Learner account and associated data deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Only admins can delete learner accounts.';
    END
END;





GO
CREATE PROCEDURE DefineLearningGoal
    @LearnerID INT,
    @GoalID INT,
    @Description NVARCHAR(255),
    @Deadline DATETIME
AS
BEGIN
    INSERT INTO Learning_goal (ID, description, deadline, status)
    VALUES (@GoalID, @Description, @Deadline, 'In Progress');

    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);
END;





GO
CREATE PROCEDURE CreateLearningPath
    @InstructorID INT,
    @LearnerID INT,
    @ProfileID INT,
    @CompletionStatus VARCHAR(50),
    @CustomContent NVARCHAR(255),
    @AdaptiveRules NVARCHAR(255)
AS
BEGIN
    INSERT INTO Learning_path (pathID, LearnerID, ProfileID, completion_status, custom_content, adaptive_rules)
    VALUES (
        (SELECT COALESCE(MAX(pathID), 0) + 1 FROM Learning_path),
        @LearnerID,
        @ProfileID,
        @CompletionStatus,
        @CustomContent,
        @AdaptiveRules
    );
END;

GO
CREATE PROCEDURE MonitorLearningPath
    @LearnerID INT
AS
BEGIN
    SELECT lp.pathID, pp.ProfileID, lp.completion_status, lp.custom_content
    FROM Learning_path lp
    INNER JOIN PersonalizationProfiles pp
        ON lp.LearnerID = pp.LearnerID AND lp.ProfileID = pp.ProfileID
    WHERE lp.LearnerID = @LearnerID;
END;


GO
CREATE PROCEDURE AdminCreateDiscussionForum
    @AdminID INT,
    @Title NVARCHAR(100),
    @ModuleID INT,
    @CourseID INT,
    @Description NVARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE username = @AdminID AND user_type IN ('Admin', 'Instructor'))
    BEGIN
        INSERT INTO Discussion_forum (ModuleID, CourseID, title, description, timestamp)
        VALUES (@ModuleID, @CourseID, @Title, @Description, GETDATE());

        PRINT 'Discussion forum created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Only admins or instructors can create discussion forums.';
    END
END;


GO
CREATE PROCEDURE ViewGoalProgress
    @LearnerID INT
AS
BEGIN
    SELECT lg.ID AS GoalID, lg.description, lgp.Status, lgp.LastUpdated
    FROM Learning_goal lg
    INNER JOIN LearningGoalProgress lgp
        ON lg.ID = lgp.GoalID
    WHERE lgp.LearnerID = @LearnerID;
END;



-- Stored Procedure: Update User Profile
GO
CREATE PROCEDURE UpdateUserProfile
    @Username INT,
    @FullName NVARCHAR(255),
    @Email NVARCHAR(255),
    @ProfilePicture NVARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET full_name = @FullName,
        email = @Email,
        profile_picture = @ProfilePicture,
        updated_at = GETDATE()
    WHERE username = @Username;

    PRINT 'User profile updated successfully.';
END;





GO
CREATE PROCEDURE ViewInfo(
@LearnerID INT
)
AS
BEGIN
SELECT * FROM Learner
WHERE LearnerID = @LearnerID;
END;





GO
CREATE PROCEDURE LearnerInfo(@LearnerID INT)
AS
BEGIN
SELECT * FROM PersonalizationProfiles
WHERE LearnerID = @LearnerID;
END;





GO
CREATE PROCEDURE EmotionalState
@LearnerID INT
AS
BEGIN
    SELECT EmotionalState
    FROM EmotionalFeedback
    WHERE LearnerID = @LearnerID
END;




GO
CREATE PROCEDURE LogDetails (@LearnerID INT)
AS
BEGIN
    SELECT LogID 
    FROM Interaction_log
    WHERE LearnerID = @LearnerID ;
    END;






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






GO
CREATE PROCEDURE CourseRemove (@CourseID INT)
AS
BEGIN
    DELETE FROM Course
    WHERE CourseID = @CourseID;
END;



    GO
    CREATE PROCEDURE Highestgrade
AS
BEGIN
    SELECT a.CourseID, a.AssessmentID, a.Total_Marks
    FROM Assessment a
    WHERE a.Total_Marks = (
        SELECT MAX(Total_Marks)
        FROM Assessment
        WHERE CourseID = a.CourseID
    );
END;
       





GO
CREATE PROCEDURE InstructorCount
AS
BEGIN
    SELECT t.CourseID, COUNT(t.InstructorID) AS InstructorCount
    FROM Teaches t
    GROUP BY t.CourseID
    HAVING COUNT(t.InstructorID) > 1; -- Only show courses with more than one instructor
END;




GO
CREATE PROCEDURE ViewNot
    @LearnerID INT
AS
BEGIN 
    SELECT 
        n.NotificationID, 
        n.timestamp, 
        n.message, 
        n.urgency_level
    FROM 
        ReceivedNotification rn
    INNER JOIN 
        Notification n ON rn.NotificationID = n.NotificationID
    WHERE 
        rn.LearnerID = @LearnerID;
END;





GO
CREATE PROCEDURE CreateDiscussion 
    @ModuleID INT, 
    @CourseID INT, 
    @Title VARCHAR(50), 
    @Description VARCHAR(50)

AS 
BEGIN
    INSERT INTO Discussion_forum ( ModuleID, CourseID, Title, Description)
    VALUES ( @ModuleID, @CourseID, @Title, @Description );
        PRINT 'Discussion added successfully.';
        SELECT 'Discussion added successfully.' AS ConfirmationMessage;
END;
   
 
   GO
CREATE PROCEDURE RemoveBadge(
@BadgeID INT
)
AS
BEGIN
    DELETE FROM Badge WHERE BadgeID = @BadgeID;
    PRINT 'Deleted successfully.';
        SELECT 'Deleted successfully.' AS ConfirmationMessage;
END;


GO
CREATE PROCEDURE CriteriaDelete(@Criteria VARCHAR(50))
AS
BEGIN
    DELETE FROM Quest WHERE Criteria = @Criteria;
END;




ALTER TABLE ReceivedNotification
ADD ReadStatus BIT DEFAULT 0;
GO
CREATE PROCEDURE NotificationUpdate
    @LearnerID INT, 
    @NotificationID INT, 
    @ReadStatus BIT
AS
BEGIN
   
    UPDATE ReceivedNotification
    SET ReadStatus = @ReadStatus
    WHERE LearnerID = @LearnerID AND NotificationID = @NotificationID;
END;





GO
CREATE PROCEDURE EmotionalTrendAnalysis
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod DATETIME
AS
BEGIN
    SELECT 
        ef.LearnerID,
        l.first_name + ' ' + l.last_name AS LearnerName,
        ef.timestamp,
        ef.emotionalState AS emotional_state,
        la.activity_type,
        la.instruction_details
    FROM 
        EmotionalFeedback ef
    INNER JOIN 
        Learner l
        ON ef.LearnerID = l.LearnerID
    INNER JOIN 
        Learning_activities la
        ON l.LearnerID = la.ModuleID 
    INNER JOIN 
        Module m
        ON la.ModuleID = m.ModuleID AND la.CourseID = m.CourseID
    WHERE 
        m.CourseID = @CourseID
        AND m.ModuleID = @ModuleID
        AND ef.timestamp >= @TimePeriod
    ORDER BY 
        ef.LearnerID, ef.timestamp;
END;






go
CREATE PROCEDURE ProfileUpdate
    @LearnerID INT,
    @ProfileID INT,
    @PreferedContentType VARCHAR(50),
    @emotional_state VARCHAR(50),
    @PersonalityType VARCHAR(50)
AS
BEGIN
    UPDATE PersonalizationProfiles
    SET 
        prefered_content_type = @PreferedContentType,
        emotional_state = @emotional_state,
        personality_type = @PersonalityType
    WHERE 
        LearnerID = @LearnerID AND ProfileID = @ProfileID;
END;



go
CREATE PROCEDURE TotalPoints
    @LearnerID INT,
    @RewardType VARCHAR(50)
AS
BEGIN
    SELECT 
        SUM(r.value) AS TotalPoints
    FROM 
        Reward r
    INNER JOIN 
        QuestReward qr
        ON r.RewardID = qr.RewardID
    WHERE 
        qr.LearnerID = @LearnerID
        AND r.type = @RewardType;
END;





go
CREATE PROCEDURE EnrolledCourses
    @LearnerID INT
AS
BEGIN
    SELECT 
        ce.CourseID,
        c.Title AS CourseTitle,
        ce.enrollment_date,
        ce.completion_date,
        ce.status
    FROM 
        Course_enrollment ce
    INNER JOIN 
        Course c
        ON ce.CourseID = c.CourseID
    WHERE 
        ce.LearnerID = @LearnerID
        AND ce.status != 'Completed'; 
END;






go
CREATE PROCEDURE Prerequisites
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM CoursePrerequisite cp
        LEFT JOIN Course_enrollment ce
        ON cp.Prereq = ce.CourseID AND ce.LearnerID = @LearnerID AND ce.status = 'Completed'
        WHERE cp.CourseID = @CourseID AND ce.CourseID IS NULL
    )
    BEGIN
        PRINT 'Not all prerequisites are completed.';
    END
    ELSE
    BEGIN
        PRINT 'All prerequisites are completed.';
    END
END;


go
CREATE PROCEDURE Moduletraits
    @TargetTrait VARCHAR(50),
    @CourseID INT
AS
BEGIN
    SELECT 
        m.ModuleID,
        m.Title AS ModuleTitle,
        m.difficulty_Level,
        m.contentURL
    FROM 
        Module m
    INNER JOIN 
        Target_traits tt
        ON m.ModuleID = tt.ModuleID AND m.CourseID = tt.CourseID
    WHERE 
        tt.Trait = @TargetTrait
        AND m.CourseID = @CourseID;
END;


go
CREATE PROCEDURE LeaderboardRank
    @LeaderboardID INT
AS
BEGIN
    SELECT 
        r.LearnerID,
        l.first_name + ' ' + l.last_name AS LearnerName,
        r.rank,
        r.total_points
    FROM 
        Ranking r
    INNER JOIN 
        Learner l
        ON r.LearnerID = l.LearnerID
    WHERE 
        r.LeaderboardID = @LeaderboardID
    ORDER BY 
        r.rank ASC;
END;




go
CREATE PROCEDURE ActivityEmotionalFeedback
    @ActivityID INT,
    @LearnerID INT,
    @timestamp DATETIME,
    @emotionalstate VARCHAR(50)
AS
BEGIN
    INSERT INTO EmotionalFeedback (LearnerID, activityId, timestamp, emotionalState)
    VALUES (@LearnerID, @ActivityID, @timestamp, @emotionalstate);
END;



GO
CREATE PROCEDURE JoinQuest
    @LearnerID INT,
    @QuestID INT
AS
BEGIN
    DECLARE @CurrentParticipants INT;
    DECLARE @MaxParticipants INT;
    DECLARE @Deadline DATETIME;

    -- Get the number of current participants from LearnersCollaboration
    SELECT 
        @CurrentParticipants = COUNT(*)
    FROM 
        LearnersCollaboration
    WHERE 
        QuestID = @QuestID;

    -- Get max participants and deadline from Collaborative table
    SELECT 
        @MaxParticipants = Max_num_participants,
        @Deadline = deadline
    FROM 
        Collaborative
    WHERE 
        QuestID = @QuestID;

    IF @CurrentParticipants < @MaxParticipants
    BEGIN
        INSERT INTO LearnersCollaboration (LearnerID, QuestID, CompletionStatus)
        VALUES (@LearnerID, @QuestID, 'In Progress');

        PRINT 'You have successfully joined the quest.';
    END
    ELSE
    BEGIN
        PRINT 'Quest is full. Unable to join.';
    END
END;







go
CREATE PROCEDURE SkillsProfeciency
    @LearnerID INT
AS
BEGIN
    SELECT 
        sp.skill AS Skill,
        sp.proficiency_level AS ProficiencyLevel,
        sp.timestamp AS LastUpdated
    FROM 
        SkillProgression sp
    WHERE 
        sp.LearnerID = @LearnerID
    ORDER BY 
        sp.timestamp DESC; 
END;
SELECT * FROM SkillProgression



go
CREATE PROCEDURE Viewscore
    @LearnerID INT,
    @AssessmentID INT,
    @score INT OUTPUT
AS
BEGIN
    SELECT 
        @score = ScoredPoint
    FROM 
        Takenassessment
    WHERE 
        LearnerID = @LearnerID AND AssessmentID = @AssessmentID;

    IF @score IS NULL
        PRINT 'No score found for the given assessment and learner.';
END;



go
CREATE PROCEDURE AssessmentsList
    @CourseID INT,
    @ModuleID INT,
    @LearnerID INT
AS
BEGIN
    SELECT 
        a.AssessmentID AS AssessmentID,
        a.title AS AssessmentTitle,
        ta.ScoredPoint AS Grade,
        a.total_marks AS TotalMarks,
        a.passing_marks AS PassingMarks
    FROM 
        Assessment a
    INNER JOIN 
        Takenassessment ta
        ON a.AssessmentID = ta.AssessmentID
    WHERE 
        a.CourseID = @CourseID AND a.ModuleID = @ModuleID AND ta.LearnerID = @LearnerID;
END;





go
CREATE PROCEDURE Courseregister
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM CoursePrerequisite cp
        LEFT JOIN Course_enrollment ce
        ON cp.Prereq = ce.CourseID AND ce.LearnerID = @LearnerID AND ce.status = 'Completed'
        WHERE cp.CourseID = @CourseID AND ce.CourseID IS NULL
    )
    BEGIN
        PRINT 'Prerequisites not completed. Registration rejected.';
    END
    ELSE
    BEGIN
        INSERT INTO Course_enrollment (EnrollmentID, CourseID, LearnerID, enrollment_date, status)
        VALUES ((SELECT COALESCE(MAX(EnrollmentID), 0) + 1 FROM Course_enrollment), 
                @CourseID, @LearnerID, GETDATE(), 'Not Started');
        PRINT 'Registration approved.';
    END
END;






go
CREATE PROCEDURE Post
    @LearnerID INT,
    @DiscussionID INT,
    @PostContent VARCHAR(MAX)
AS
BEGIN
    INSERT INTO LearnerDiscussion (ForumID, LearnerID, Post, time)
    VALUES (@DiscussionID, @LearnerID, @PostContent, GETDATE());
END;




go
CREATE PROCEDURE AddGoal
    @LearnerID INT,
    @GoalID INT
AS
BEGIN
    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);
END;







go
CREATE PROCEDURE CurrentPath
    @LearnerID INT
AS
BEGIN
    SELECT 
        lp.pathID AS PathID,
        pp.ProfileID,
        pp.prefered_content_type AS ContentPreference,
        lp.completion_status AS Status,
        lp.custom_content AS CustomContent,
        lp.adaptive_rules AS AdaptiveRules
    FROM 
        Learning_path lp
    INNER JOIN 
        PersonalizationProfiles pp
        ON lp.LearnerID = pp.LearnerID AND lp.ProfileID = pp.ProfileID
    WHERE 
        lp.LearnerID = @LearnerID;
END;





GO
CREATE PROCEDURE QuestMembers
    @LearnerID INT
AS
BEGIN
    SELECT 
        lc.QuestID,
        l.LearnerID,
        l.first_name + ' ' + l.last_name AS MemberName,
        c.deadline
    FROM 
        LearnersCollaboration lc
    INNER JOIN 
        Collaborative c ON lc.QuestID = c.QuestID
    INNER JOIN 
        Learner l ON lc.LearnerID = l.LearnerID
    WHERE 
        lc.QuestID IN (
            SELECT QuestID 
            FROM LearnersCollaboration 
            WHERE LearnerID = @LearnerID
        )
        AND c.deadline >= GETDATE();
END;




go
CREATE PROCEDURE QuestProgress
    @LearnerID INT
AS
BEGIN
    SELECT 
        q.QuestID,
        q.title AS QuestTitle,
        lm.CompletionStatus AS QuestStatus,
        b.BadgeID,
        b.title AS BadgeTitle,
        a.date_earned AS BadgeEarnedDate
    FROM 
        Quest q
    LEFT JOIN 
        LearnersMastery lm
        ON q.QuestID = lm.QuestID AND lm.LearnerID = @LearnerID
    LEFT JOIN 
        Achievement a
        ON a.LearnerID = @LearnerID
    LEFT JOIN 
        Badge b
        ON a.BadgeID = b.BadgeID
    WHERE 
        lm.CompletionStatus IS NOT NULL OR a.BadgeID IS NOT NULL;
END;





go
 CREATE PROCEDURE GoalReminder
    @LearnerID INT
AS
BEGIN
    SELECT 
        lg.ID AS GoalID,
        lg.description AS GoalDescription,
        lg.deadline,
        CASE 
            WHEN GETDATE() > lg.deadline THEN 'Overdue'
            ELSE 'On Track'
        END AS Status
    FROM 
        Learning_goal lg
    INNER JOIN 
        LearnersGoals lgp
        ON lg.ID = lgp.GoalID
    WHERE 
        lgp.LearnerID = @LearnerID;

    IF EXISTS (
        SELECT 1 
        FROM Learning_goal lg
        INNER JOIN LearnersGoals lgp
        ON lg.ID = lgp.GoalID
        WHERE lgp.LearnerID = @LearnerID AND GETDATE() > lg.deadline
    )
    BEGIN
        PRINT 'Reminder: You have goals that are overdue.';
    END;
END;





go
CREATE PROCEDURE SkillProgressHistory
    @LearnerID INT,
    @Skill VARCHAR(50)
AS
BEGIN
    SELECT 
        sp.timestamp AS Date,
        sp.proficiency_level AS ProficiencyLevel
    FROM 
        SkillProgression sp
    WHERE 
        sp.LearnerID = @LearnerID AND sp.skill = @Skill
    ORDER BY 
        sp.timestamp ASC;
END;




go
CREATE PROCEDURE AssessmentAnalysis
    @LearnerID INT
AS
BEGIN
    SELECT 
        a.AssessmentID AS AssessmentID,
        a.title AS AssessmentTitle,
        ta.ScoredPoint AS Score,
        a.total_marks AS TotalMarks,
        a.passing_marks AS PassingMarks,
        CASE 
            WHEN ta.ScoredPoint >= a.passing_marks THEN 'Strength'
            ELSE 'Weakness'
        END AS Performance
    FROM 
        Assessment a
    INNER JOIN 
        Takenassessment ta
        ON a.AssessmentID = ta.AssessmentID
    WHERE 
        ta.LearnerID = @LearnerID
    ORDER BY 
        ta.ScoredPoint DESC;
END;




go
CREATE PROCEDURE LeaderboardFilter
    @LearnerID INT
AS
BEGIN
    SELECT 
        r.LeaderboardID,
        lb.season AS LeaderboardSeason,
        r.LearnerID,
        l.first_name + ' ' + l.last_name AS LearnerName,
        r.rank,
        r.total_points AS TotalPoints
    FROM 
        Ranking r
    INNER JOIN 
        Leaderboard lb
        ON r.LeaderboardID = lb.LeaderboardID
    INNER JOIN 
        Learner l
        ON r.LearnerID = l.LearnerID
    WHERE 
        r.LearnerID = @LearnerID
    ORDER BY 
        r.rank DESC; 
END;



go
CREATE PROCEDURE SkillLearners
    @SkillName VARCHAR(50)
AS
BEGIN
    SELECT 
        s.skill_name AS SkillName,
        l.LearnerID,
        l.first_name + ' ' + l.last_name AS LearnerName
    FROM 
        Skills s
    INNER JOIN 
        Learner l
        ON s.LearnerID = l.LearnerID
    WHERE 
        s.skill_name = @SkillName;
END;




go
CREATE PROCEDURE NewActivity
    @CourseID INT,
    @ModuleID INT,
    @ActivityType VARCHAR(50),
    @InstructionDetails VARCHAR(MAX),
    @MaxPoints INT
AS
BEGIN
    INSERT INTO Learning_activities (ActivityID, ModuleID, CourseID, activity_type, instruction_details, Max_points)
    VALUES (
        (SELECT COALESCE(MAX(ActivityID), 0) + 1 FROM Learning_activities), 
        @ModuleID, 
        @CourseID, 
        @ActivityType, 
        @InstructionDetails, 
        @MaxPoints
    );
END;



go
CREATE PROCEDURE NewAchievement
    @LearnerID INT,
    @BadgeID INT,
    @Description VARCHAR(MAX),
    @Date_Earned DATE,
    @Type VARCHAR(50)
AS
BEGIN
    INSERT INTO Achievement (AchievementID, LearnerID, BadgeID, description, date_earned, type)
    VALUES (
        (SELECT COALESCE(MAX(AchievementID), 0) + 1 FROM Achievement), 
        @LearnerID, 
        @BadgeID, 
        @Description, 
        @Date_Earned, 
        @Type
    );
END;



go
CREATE PROCEDURE LearnerBadge
    @BadgeID INT
AS
BEGIN
    SELECT 
        a.LearnerID,
        l.first_name + ' ' + l.last_name AS LearnerName,
        a.date_earned AS DateEarned,
        a.description AS AchievementDescription
    FROM 
        Achievement a
    INNER JOIN 
        Learner l
        ON a.LearnerID = l.LearnerID
    WHERE 
        a.BadgeID = @BadgeID;
END;




GO
CREATE PROCEDURE NewPath
    @LearnerID INT,
    @ProfileID INT,
    @Completion_Status VARCHAR(50),
    @Custom_Content VARCHAR(MAX),
    @AdaptiveRules VARCHAR(MAX)
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM PersonalizationProfiles 
        WHERE LearnerID = @LearnerID AND ProfileID = @ProfileID
    )
    BEGIN
        PRINT 'Error: LearnerID or ProfileID does not exist in PersonalizationProfiles.'
        RETURN;
    END;

    INSERT INTO Learning_path (pathID, LearnerID, ProfileID, completion_status, custom_content, adaptive_rules)
    VALUES (
        (SELECT COALESCE(MAX(pathID), 0) + 1 FROM Learning_path), 
        @LearnerID, 
        @ProfileID, 
        @Completion_Status, 
        @Custom_Content, 
        @AdaptiveRules
    );

    PRINT 'New learning path added successfully.';
END;




go
CREATE PROCEDURE TakenCourses
    @LearnerID INT
AS
BEGIN
    SELECT 
        ce.CourseID,
        c.Title AS CourseTitle,
        ce.enrollment_date AS EnrollmentDate,
        ce.completion_date AS CompletionDate,
        ce.status AS Status
    FROM 
        Course_enrollment ce
    INNER JOIN 
        Course c
        ON ce.CourseID = c.CourseID
    WHERE 
        ce.LearnerID = @LearnerID
        AND ce.status = 'Completed'; 
END;





DROP PROCEDURE CollaborativeQuest;
GO
CREATE PROCEDURE CollaborativeQuest
    @difficulty_level VARCHAR(50),
    @criteria VARCHAR(50),
    @description VARCHAR(255),
    @title VARCHAR(50),
    @Maxnumparticipants INT,
    @deadline DATETIME
AS
BEGIN
    -- Insert into Quest table
    INSERT INTO Quest (QuestID, difficulty_level, criteria, description, title)
    VALUES (
        (SELECT COALESCE(MAX(QuestID), 0) + 1 FROM Quest), 
        @difficulty_level, 
        @criteria, 
        @description, 
        @title
    );

    -- Insert into Collaborative table
    INSERT INTO Collaborative (QuestID,  deadline, Max_num_participants)
    VALUES (
        (SELECT MAX(QuestID) FROM Quest), 
        
        @deadline, 
        @Maxnumparticipants
    );
END;


go
CREATE PROCEDURE DeadlineUpdate
    @QuestID INT,
    @deadline DATETIME
AS
BEGIN
    UPDATE Collaborative
    SET deadline = @deadline
    WHERE QuestID = @QuestID;

   
END;

EXEC DeadlineUpdate @QuestID = 1, @deadline = '2025-01-15';


go
CREATE PROCEDURE GradeUpdate
    @LearnerID INT,
    @AssessmentID INT,
    @points INT
AS
BEGIN
    UPDATE Takenassessment
    SET ScoredPoint = @points
    WHERE LearnerID = @LearnerID AND AssessmentID = @AssessmentID;

    PRINT 'Grade updated successfully.';
END;





GO
CREATE PROCEDURE AssessmentNot
    @NotificationID INT,
    @message VARCHAR(MAX),
    @urgencylevel VARCHAR(50),
    @LearnerID INT
AS
BEGIN
    INSERT INTO Notification (NotificationID, message, urgency_level)
    VALUES (@NotificationID, @message, @urgencylevel);

    INSERT INTO ReceivedNotification (NotificationID, LearnerID)
    VALUES (@NotificationID, @LearnerID);

    PRINT 'Notification sent successfully.';
END;


go
CREATE PROCEDURE NewGoal
    @GoalID INT,
    @status VARCHAR(MAX),
    @deadline DATETIME,
    @description VARCHAR(MAX)
AS
BEGIN
    INSERT INTO Learning_goal (ID, status, deadline, description)
    VALUES (@GoalID, @status, @deadline, @description);
END;





go
CREATE PROCEDURE LearnersCourses
    @CourseID INT,
    @InstructorID INT
AS
BEGIN
    SELECT 
        ce.CourseID,
        c.Title AS CourseTitle,
        ce.LearnerID,
        l.first_name + ' ' + l.last_name AS LearnerName,
        ce.enrollment_date AS EnrollmentDate,
        ce.status AS Status
    FROM 
        Course_enrollment ce
    INNER JOIN 
        Course c
        ON ce.CourseID = c.CourseID
    INNER JOIN 
        Learner l
        ON ce.LearnerID = l.LearnerID
    INNER JOIN 
        Teaches t
        ON t.CourseID = ce.CourseID
    WHERE 
        ce.CourseID = @CourseID AND t.InstructorID = @InstructorID;
END;






go
CREATE PROCEDURE LastActive
    @ForumID INT,
    @lastactive DATETIME OUTPUT
AS
BEGIN
    SELECT 
        @lastactive = last_active
    FROM 
        Discussion_forum
    WHERE 
        forumID = @ForumID;
END;





go
CREATE PROCEDURE CommonEmotionalState
    @state VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1 
        @state = emotionalState
    FROM 
        EmotionalFeedback
    GROUP BY 
        emotionalState
    ORDER BY 
        COUNT(*) DESC;
END;


go
CREATE PROCEDURE ModuleDifficulty
    @CourseID INT
AS
BEGIN
    SELECT 
        ModuleID,
        Title AS ModuleTitle,
        difficulty_Level,
        contentURL
    FROM 
        Module
    WHERE 
        CourseID = @CourseID
    ORDER BY 
        CASE 
            WHEN difficulty_Level = 'Beginner' THEN 1
            WHEN difficulty_Level = 'Intermediate' THEN 2
            WHEN difficulty_Level = 'Advanced' THEN 3
            
        END;
END;



GO
CREATE PROCEDURE Profeciencylevel
    @LearnerID INT,
    @skill VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1 
        @skill = skill
    FROM 
        SkillProgression
    WHERE 
        LearnerID = @LearnerID
    ORDER BY 
        proficiency_level DESC; 
END;



GO
CREATE PROCEDURE Profeciencylevel
    @LearnerID INT,
    @skill VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1 
        @skill = skill
    FROM 
        SkillProgression
    WHERE 
        LearnerID = @LearnerID
    ORDER BY 
        proficiency_level DESC;
END;


go
CREATE PROCEDURE LeastBadge
    @LearnerID INT OUTPUT
AS
BEGIN
    SELECT TOP 1 
        @LearnerID = LearnerID
    FROM 
        Achievement
    GROUP BY 
        LearnerID
    ORDER BY 
        COUNT(BadgeID) ASC;
END;




go
CREATE PROCEDURE PreferedType
    @type VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1 
        @type = preference
    FROM 
        learning_preferences
    GROUP BY 
        preference
    ORDER BY 
        COUNT(*) DESC;
END;







go 
CREATE PROCEDURE AssessmentAnalytics
    @CourseID INT,
    @ModuleID INT
AS
BEGIN
    SELECT 
        a.AssessmentID AS AssessmentID,
        a.title AS AssessmentTitle,
        AVG(ta.ScoredPoint) AS AverageScore
    FROM 
        Assessment a
    INNER JOIN 
        Takenassessment ta
        ON a.AssessmentID = ta.AssessmentID
    WHERE 
        a.CourseID = @CourseID AND a.ModuleID = @ModuleID
    GROUP BY 
        a.AssessmentID, a.title;
END;




go
CREATE PROCEDURE EmotionalTrendAnalysisIns
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod DATETIME
AS
BEGIN
    SELECT 
        ef.LearnerID,
        l.first_name + ' ' + l.last_name AS LearnerName,
        ef.timestamp,
        ef.emotionalState
    FROM 
        EmotionalFeedback ef
    INNER JOIN 
        Learning_activities la
        ON ef.activityID = la.ActivityID
    INNER JOIN 
        Learner l
        ON ef.LearnerID = l.LearnerID
    WHERE 
        la.CourseID = @CourseID AND la.ModuleID = @ModuleID AND ef.timestamp >= @TimePeriod
    ORDER BY 
        ef.timestamp ASC;
END;



GO
CREATE PROCEDURE ValidateUserLogin
    @Email NVARCHAR(255),
    @Password NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT username AS Id, full_name AS Name, user_type AS Role
    FROM Users
    WHERE email = @Email AND password = @Password;
END;



GO
CREATE PROCEDURE DeleteLearnerAccount
    @LearnerID INT
AS
BEGIN
    DELETE FROM ReceivedNotification WHERE LearnerID = @LearnerID;
    DELETE FROM Course_enrollment WHERE LearnerID = @LearnerID;
    DELETE FROM PersonalizationProfiles WHERE LearnerID = @LearnerID;
    DELETE FROM Learning_path WHERE LearnerID = @LearnerID;
    DELETE FROM Learner WHERE LearnerID = @LearnerID;
    PRINT 'Learner account and associated data deleted successfully.';
END;
ALTER TABLE Users
ADD ProfilePicture NVARCHAR(255); -- Path or URL to the image
GO
CREATE PROCEDURE UploadProfilePicture
    @username INT,
    @ProfilePicture NVARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET ProfilePicture = @ProfilePicture
    WHERE username = @username;
END;







GO
CREATE PROCEDURE AddPostToDiscussion
    @ForumID INT,
    @LearnerID INT,
    @PostContent NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO LearnerDiscussion (ForumID, LearnerID, Post, time)
    VALUES (@ForumID, @LearnerID, @PostContent, GETDATE());

    PRINT 'Post added successfully.';
END;





GO
CREATE PROCEDURE ViewUserProfile
    @Username INT
AS
BEGIN
    SELECT 
        username AS UserID,
        full_name AS FullName,
        email AS Email,
        user_type AS Role,
        profile_picture AS ProfilePicture,
        created_at AS CreatedAt
    FROM Users
    WHERE username = @Username;
END;





GO
CREATE PROCEDURE UpdatePersonalInfo
    @Username INT,
    @FullName NVARCHAR(255),
    @Email NVARCHAR(255)
AS
BEGIN
    UPDATE Users
    SET full_name = @FullName,
        email = @Email,
        updated_at = GETDATE()
    WHERE username = @Username;

    PRINT 'Profile updated successfully.';
END;




GO
CREATE PROCEDURE ViewActiveForums
AS
BEGIN
    SELECT 
        forumID AS ForumID,
        title AS ForumTitle,
        description AS Description,
        timestamp AS CreatedAt
    FROM Discussion_forum;
END;




GO
CREATE PROCEDURE AddNewActivity
    @ModuleID INT,
    @CourseID INT,
    @ActivityType VARCHAR(50),
    @Instructions VARCHAR(MAX),
    @MaxPoints INT
AS
BEGIN
    INSERT INTO Learning_activities (ActivityID, ModuleID, CourseID, activity_type, instruction_details, Max_points)
    VALUES ((SELECT COALESCE(MAX(ActivityID), 0) + 1 FROM Learning_activities), 
            @ModuleID, 
            @CourseID, 
            @ActivityType, 
            @Instructions, 
            @MaxPoints);
END;


--chatgpt
GO
CREATE PROCEDURE GetCourseModules
    @CourseID INT
AS
BEGIN
    SELECT ModuleID, Title, Description, Status
    FROM Module
    WHERE CourseID = @CourseID;
END;


GO
CREATE PROCEDURE EnrolledCourses
    @LearnerID INT
AS
BEGIN
    SELECT ce.CourseID, c.Title AS CourseTitle, ce.enrollment_date, ce.completion_date, ce.status
    FROM Course_enrollment ce
    INNER JOIN Course c
    ON ce.CourseID = c.CourseID
    WHERE ce.LearnerID = @LearnerID AND ce.status != 'Completed'; 
END;



GO
CREATE PROCEDURE TakenCourses
    @LearnerID INT
AS
BEGIN
    SELECT ce.CourseID, c.Title AS CourseTitle, ce.enrollment_date, ce.completion_date, ce.status
    FROM Course_enrollment ce
    INNER JOIN Course c
    ON ce.CourseID = c.CourseID
    WHERE ce.LearnerID = @LearnerID AND ce.status = 'Completed'; 
END;




GO
CREATE PROCEDURE Prerequisites
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM CoursePrerequisite cp
        LEFT JOIN Course_enrollment ce
        ON cp.Prereq = ce.CourseID AND ce.LearnerID = @LearnerID AND ce.status = 'Completed'
        WHERE cp.CourseID = @CourseID AND ce.CourseID IS NULL
    )
    BEGIN
        PRINT 'Not all prerequisites are completed.';
    END
    ELSE
    BEGIN
        PRINT 'All prerequisites are completed.';
    END
END;



GO
CREATE PROCEDURE DeleteCourse
    @InstructorID INT,
    @CourseID INT
AS
BEGIN
    -- Check if no learners are enrolled in the course
    IF NOT EXISTS (SELECT 1 FROM Course_enrollment WHERE CourseID = @CourseID)
    BEGIN
        DELETE FROM Course WHERE CourseID = @CourseID;
        PRINT 'Course deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Course cannot be deleted because there are enrolled learners.';
    END
END;


GO
CREATE PROCEDURE Courseregister
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM CoursePrerequisite cp
        LEFT JOIN Course_enrollment ce
        ON cp.Prereq = ce.CourseID AND ce.LearnerID = @LearnerID AND ce.status = 'Completed'
        WHERE cp.CourseID = @CourseID AND ce.CourseID IS NULL
    )
    BEGIN
        PRINT 'Prerequisites not completed. Registration rejected.';
    END
    ELSE
    BEGIN
        INSERT INTO Course_enrollment (EnrollmentID, CourseID, LearnerID, enrollment_date, status)
        VALUES ((SELECT COALESCE(MAX(EnrollmentID), 0) + 1 FROM Course_enrollment), 
                @CourseID, @LearnerID, GETDATE(), 'Not Started');
        PRINT 'Registration approved.';
    END
END;
