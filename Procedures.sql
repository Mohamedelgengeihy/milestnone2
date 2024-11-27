CREATE DATABASE GENGO;

USE GENGO;

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
EXEC ViewInfo @LearnerID = 1;

GO
CREATE PROCEDURE LearnerInfo(@LearnerID INT)
AS
BEGIN
SELECT * FROM PersonalizationProfiles
WHERE LearnerID = @LearnerID;
END;
DROP PROCEDURE LearnerInfo
EXEC LearnerInfo @LearnerID = 1;

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

GO
CREATE PROCEDURE CourseRemove (@CourseID INT)
AS
BEGIN
    DELETE FROM Course
    WHERE CourseID = @CourseID;
END;
DROP PROC CourseRemove

EXEC CourseRemove @CourseID = 1


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
    exec HighestGrade 
        DROP PROC HighestGrade
       





GO
CREATE PROCEDURE InstructorCount
AS
BEGIN
    SELECT t.CourseID, COUNT(t.InstructorID) AS InstructorCount
    FROM Teaches t
    GROUP BY t.CourseID
    HAVING COUNT(t.InstructorID) > 1; -- Only show courses with more than one instructor
END;
    DROP PROC InstructorCount
    EXEC InstructorCount




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
EXEC ViewNot @LearnerID = 1;
    DROP PROCEDURE ViewNot

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
END;
DROP PROCEDURE CreateDiscussion
EXEC CreateDiscussion @ModuleID = 1, @CourseID = 103, @Title = 'Discussion 1', @Description = 'Discuss the module content';
   
   
   
 
   GO
CREATE PROCEDURE RemoveBadge(
@BadgeID INT
)
AS
BEGIN
    DELETE FROM Badge WHERE BadgeID = @BadgeID;
END;
DROP PROCEDURE RemoveBadge
EXEC RemoveBadge @BadgeID = 2;
SELECT * FROM Badge;




GO
CREATE PROCEDURE CriteriaDelete(@Criteria VARCHAR(50))
AS
BEGIN
    DELETE FROM Quest WHERE Criteria = @Criteria;
END;
EXEC CriteriaDelete @Criteria = 'Complete 5 activities';
DROP PROCEDURE CriteriaDelete
SELECT * FROM Quest;





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

EXEC NotificationUpdate @LearnerID = 1, @NotificationID = 1, @ReadStatus = 1;
SELECT * FROM ReceivedNotification
DROP PROCEDURE NotificationUpdate



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

EXEC EmotionalTrendAnalysis @CourseID = 102, @ModuleID = 1, @TimePeriod = '2024-11-01';





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
SELECT * FROM PersonalizationProfiles
EXEC ProfileUpdate @LearnerID = 1, @ProfileID = 1, 
                   @PreferedContentType = 'Interactive Video', 
                   @emotional_state = 'Motivated', 
                   @PersonalityType = 'Introverted';



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

EXEC TotalPoints @LearnerID = 1, @RewardType = 'Voucher';




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
DROP PROCEDURE EnrolledCourses
EXEC EnrolledCourses @LearnerID = 1;






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
DROP PROCEDURE Prerequisites
EXEC Prerequisites @LearnerID = 1, @CourseID = 102;
SELECT * FROM CoursePrerequisite;



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
EXEC Moduletraits @TargetTrait = 'Critical Thinking', @CourseID = 104;


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
EXEC LeaderboardRank @LeaderboardID = 2;




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
DROP PROCEDURE ActivityEmotionalFeedback
EXEC ActivityEmotionalFeedback @ActivityID = 2, @LearnerID = 1, @timestamp = '2024-11-25 14:00:00', @emotionalstate = 'Excited';
SELECT * FROM EmotionalFeedback;



GO
CREATE PROCEDURE JoinQuest
    @LearnerID INT,
    @QuestID INT
AS
BEGIN
    DECLARE @CurrentParticipants INT;
    DECLARE @MaxParticipants INT;
    DECLARE @Deadline DATE;

    SELECT 
        @CurrentParticipants = COUNT(*)
    FROM 
        Collaborative
    WHERE 
        QuestID = @QuestID;

    SELECT 
        @MaxParticipants = Max_num_participants,
        @Deadline = deadline
    FROM 
        Collaborative
    WHERE 
        QuestID = @QuestID;

    IF @CurrentParticipants < @MaxParticipants
    BEGIN
        INSERT INTO Collaborative (QuestID, LearnerID, deadline, Max_num_participants)
        VALUES (@QuestID, @LearnerID, @Deadline, @MaxParticipants);

        PRINT 'You have successfully joined the quest.';
    END
    ELSE
    BEGIN
        PRINT 'Quest is full. Unable to join.';
    END
END;
EXEC JoinQuest @LearnerID = 1, @QuestID = 2;






go
CREATE PROCEDURE SkillsProfeciency
    @LearnerID INT
AS
BEGIN
    SELECT 
        sp.skill_name AS Skill,
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

EXEC SkillsProfeciency @LearnerID = 1;


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

DECLARE @score INT;
EXEC Viewscore @LearnerID = 1, @AssessmentID = 1, @score = @score OUTPUT;
PRINT @score;


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
EXEC AssessmentsList @CourseID = 103, @ModuleID = 1, @LearnerID = 1;





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

EXEC Courseregister @LearnerID = 1, @CourseID = 103;





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

EXEC Post @LearnerID = 1, @DiscussionID = 1, 
          @PostContent = 'This is a helpful discussion on programming basics.';




go
CREATE PROCEDURE AddGoal
    @LearnerID INT,
    @GoalID INT
AS
BEGIN
    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);
END;

EXEC AddGoal @LearnerID = 1, @GoalID = 3;





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

EXEC CurrentPath @LearnerID = 1;




go
CREATE PROCEDURE QuestMembers
    @LearnerID INT
AS
BEGIN
    SELECT 
        lc.QuestID,
        l.LearnerID,
        l.first_name + ' ' + l.last_name AS MemberName,
        cq.deadline
    FROM 
        Collaborative lc
    INNER JOIN 
        Collaborative my_quests
        ON lc.QuestID = my_quests.QuestID
    INNER JOIN 
        Collaborative cq
        ON lc.QuestID = cq.QuestID
    INNER JOIN 
        Learner l
        ON lc.LearnerID = l.LearnerID
    WHERE 
        my_quests.LearnerID = @LearnerID
        AND cq.deadline >= GETDATE();
END;

EXEC QuestMembers @LearnerID = 1;


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

 eXEC QuestProgress @LearnerID = 120;

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
        PRINT 'Reminder: You have goals that are overdue. Please review your learning goals timeline.';
    END;
END;

exec GoalReminder @LearnerID = 1;





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
        sp.LearnerID = @LearnerID AND sp.skill_name = @Skill
    ORDER BY 
        sp.timestamp ASC;
END;
DROP PROCEDURE SkillProgressHistory
EXEC SkillProgressHistory @LearnerID = 1, @Skill = 'Data Analysis';
SELECT * FROM SkillProgression;




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
EXEC AssessmentAnalysis @LearnerID = 1;




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

exec LeaderboardFilter @LearnerID = 2;


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

EXEC SkillLearners @SkillName = 'Java';



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

EXEC NewActivity @CourseID = 103, @ModuleID = 1, @ActivityType = 'Quiz', @InstructionDetails = 'Complete the quiz to test your knowledge.', @MaxPoints = 10;


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

EXEC NewAchievement @LearnerID = 2, 
                    @BadgeID = 3, 
                    @Description = 'Scored above 90% on final exam.', 
                    @Date_Earned = '2024-12-01', 
                    @Type = 'Exam Achievement';


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

EXEC LearnerBadge @BadgeID = 3;



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
        PRINT 'Error: LearnerID or ProfileID does not exist in PersonalizationProfiles.';
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
EXEC NewPath @LearnerID = 1, 
             @ProfileID = 1, 
             @Completion_Status = 'In Progress', 
             @Custom_Content = 'Custom content for the learner', 
             @AdaptiveRules = 'Adaptive rules for the learner';





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
EXEC TakenCourses @LearnerID = 2;




go
CREATE PROCEDURE CollaborativeQuest
    @difficulty_level VARCHAR(50),
    @criteria VARCHAR(50),
    @description VARCHAR(50),
    @title VARCHAR(50),
    @Maxnumparticipants INT,
    @deadline DATETIME
AS
BEGIN
    INSERT INTO Quest (QuestID, difficulty_level, criteria, description, title)
    VALUES (
        (SELECT COALESCE(MAX(QuestID), 0) + 1 FROM Quest), 
        @difficulty_level, 
        @criteria, 
        @description, 
        @title
    );

    INSERT INTO Collaborative (QuestID, deadline, max_num_participants)
    VALUES (
        (SELECT MAX(QuestID) FROM Quest), 
        @deadline, 
        @Maxnumparticipants
    );
END;
DROP PROCEDURE CollaborativeQuest
Exec CollaborativeQuest @difficulty_level = 'Intermediate', @criteria = 'Complete 5 activities', @description = 'Complete the intermediate level activities', @title = 'Intermediate Quest', @Maxnumparticipants = 5, @deadline = '2024-12-31';




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

EXEC DeadlineUpdate @QuestID = 2, @deadline = '2025-01-15';


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

EXEC GradeUpdate @LearnerID = 3, @AssessmentID = 1, @points = 95;




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

EXEC AssessmentNot @NotificationID = 2, @message = 'New assessment available for completion.', @urgencylevel = 'High', @LearnerID = 1;





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
EXEC NewGoal @GoalID = 4, @status = 'In Progress', @deadline = '2025-01-31', @description = 'Complete all advanced level activities.';





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
EXEC LearnersCourses @CourseID = 102, @InstructorID = 4;






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

DECLARE @lastactive DATETIME;
EXEC LastActive @ForumID = 1, @lastactive = @lastactive OUTPUT;
SELECT @lastactive AS LastActiveTime;




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
DECLARE @state VARCHAR(50);
EXEC CommonEmotionalState @state = @state OUTPUT;
PRINT @state;


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
EXEC ModuleDifficulty @CourseID = 103;



GO
CREATE PROCEDURE Profeciencylevel
    @LearnerID INT,
    @skill VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1 
        @skill = skill_name
    FROM 
        SkillProgression
    WHERE 
        LearnerID = @LearnerID
    ORDER BY 
        proficiency_level DESC; 
END;
DECLARE @skill VARCHAR(50);
EXEC Profeciencylevel @LearnerID = 1, @skill = @skill OUTPUT;
SELECT @skill AS HighestProficiencySkill;



GO
CREATE PROCEDURE Profeciencylevel
    @LearnerID INT,
    @skill VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1 
        @skill = skill_name
    FROM 
        SkillProgression
    WHERE 
        LearnerID = @LearnerID
    ORDER BY 
        proficiency_level DESC;
END;
DECLARE @skill VARCHAR(50);
EXEC Profeciencylevel @LearnerID = 1, @skill = @skill OUTPUT;
SELECT @skill AS HighestProficiencySkill;



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
DROP PROCEDURE LeastBadge
DECLARE @LearnerID INT;
EXEC LeastBadge @LearnerID = @LearnerID OUTPUT;
PRINT @LearnerID;




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
DECLARE @type VARCHAR(50);
EXEC PreferedType @type = @type OUTPUT;
PRINT @type;






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
DROP    PROCEDURE AssessmentAnalytics

EXEC AssessmentAnalytics @CourseID = 103, @ModuleID = 1;


-- View trends in learners’ emotional feedback to support well-being in courses I teach.

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
EXEC EmotionalTrendAnalysisIns @CourseID = 103, @ModuleID = 1, @TimePeriod = '2024-11-01';