using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace YarabFinal.Models;

public partial class GengoContext : DbContext
{
    public GengoContext()
    {
    }

    public GengoContext(DbContextOptions<GengoContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Achievement> Achievements { get; set; }

    public virtual DbSet<Admin> Admins { get; set; }

    public virtual DbSet<Admin1> Admins1 { get; set; }

    public virtual DbSet<Assessment> Assessments { get; set; }

    public virtual DbSet<Badge> Badges { get; set; }

    public virtual DbSet<Collaborative> Collaboratives { get; set; }

    public virtual DbSet<ContentLibrary> ContentLibraries { get; set; }

    public virtual DbSet<Course> Courses { get; set; }

    public virtual DbSet<CourseEnrollment> CourseEnrollments { get; set; }

    public virtual DbSet<CoursePrerequisite> CoursePrerequisites { get; set; }

    public virtual DbSet<DiscussionForum> DiscussionForums { get; set; }

    public virtual DbSet<EmotionalFeedback> EmotionalFeedbacks { get; set; }

    public virtual DbSet<EmotionalfeedbackReview> EmotionalfeedbackReviews { get; set; }

    public virtual DbSet<FilledSurvey> FilledSurveys { get; set; }

    public virtual DbSet<HealthCondtion> HealthCondtions { get; set; }

    public virtual DbSet<Instructor> Instructors { get; set; }

    public virtual DbSet<InteractionLog> InteractionLogs { get; set; }

    public virtual DbSet<Leaderboard> Leaderboards { get; set; }

    public virtual DbSet<Learner> Learners { get; set; }

    public virtual DbSet<LearnerDiscussion> LearnerDiscussions { get; set; }

    public virtual DbSet<LearnersCollaboration> LearnersCollaborations { get; set; }

    public virtual DbSet<LearnersMastery> LearnersMasteries { get; set; }

    public virtual DbSet<LearningActivity> LearningActivities { get; set; }

    public virtual DbSet<LearningGoal> LearningGoals { get; set; }

    public virtual DbSet<LearningGoalProgress> LearningGoalProgresses { get; set; }

    public virtual DbSet<LearningPath> LearningPaths { get; set; }

    public virtual DbSet<LearningPreference> LearningPreferences { get; set; }

    public virtual DbSet<Module> Modules { get; set; }

    public virtual DbSet<ModuleContent> ModuleContents { get; set; }

    public virtual DbSet<Notification> Notifications { get; set; }

    public virtual DbSet<Pathreview> Pathreviews { get; set; }

    public virtual DbSet<PersonalizationProfile> PersonalizationProfiles { get; set; }

    public virtual DbSet<Quest> Quests { get; set; }

    public virtual DbSet<QuestReward> QuestRewards { get; set; }

    public virtual DbSet<Ranking> Rankings { get; set; }

    public virtual DbSet<ReceivedNotification> ReceivedNotifications { get; set; }

    public virtual DbSet<Reward> Rewards { get; set; }

    public virtual DbSet<Skill> Skills { get; set; }

    public virtual DbSet<SkillMasterySkill> SkillMasterySkills { get; set; }

    public virtual DbSet<SkillProgression> SkillProgressions { get; set; }

    public virtual DbSet<Survey> Surveys { get; set; }

    public virtual DbSet<SurveyQuestion> SurveyQuestions { get; set; }

    public virtual DbSet<Takenassessment> Takenassessments { get; set; }

    public virtual DbSet<TargetTrait> TargetTraits { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=(localdb)\\MSSQLLocalDB;Database=GENGO;Trusted_Connection=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Achievement>(entity =>
        {
            entity.HasKey(e => e.AchievementId).HasName("PK__Achievem__276330E09C331EAC");

            entity.ToTable("Achievement");

            entity.Property(e => e.AchievementId)
                .ValueGeneratedNever()
                .HasColumnName("AchievementID");
            entity.Property(e => e.BadgeId).HasColumnName("BadgeID");
            entity.Property(e => e.DateEarned).HasColumnName("date_earned");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Type)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("type");

            entity.HasOne(d => d.Badge).WithMany(p => p.Achievements)
                .HasForeignKey(d => d.BadgeId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Achieveme__Badge__2739D489");

            entity.HasOne(d => d.Learner).WithMany(p => p.Achievements)
                .HasForeignKey(d => d.LearnerId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Achieveme__Learn__2645B050");
        });

        modelBuilder.Entity<Admin>(entity =>
        {
            entity.HasKey(e => e.AdminId).HasName("PK__Admin__719FE4E84A4EA3BE");

            entity.ToTable("Admin");

            entity.HasIndex(e => e.Email, "UQ__Admin__A9D10534E9A8BC20").IsUnique();

            entity.Property(e => e.AdminId).HasColumnName("AdminID");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Email).HasMaxLength(150);
            entity.Property(e => e.Name).HasMaxLength(100);
            entity.Property(e => e.Password).HasMaxLength(255);
            entity.Property(e => e.Role)
                .HasMaxLength(50)
                .HasDefaultValue("Admin");
        });

        modelBuilder.Entity<Admin1>(entity =>
        {
            entity.HasKey(e => e.AdminId).HasName("PK__Admins__43AA4141FE807C9F");

            entity.ToTable("Admins");

            entity.Property(e => e.AdminId).HasColumnName("admin_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Permissions).HasColumnName("permissions");
            entity.Property(e => e.Username).HasColumnName("username");

            entity.HasOne(d => d.UsernameNavigation).WithMany(p => p.Admin1s)
                .HasForeignKey(d => d.Username)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Admins__username__540C7B00");
        });

        modelBuilder.Entity<Assessment>(entity =>
        {
            entity.HasKey(e => e.AssessmentId).HasName("PK__Assessme__3D2BF83E1A767B3C");

            entity.ToTable("Assessment");

            entity.Property(e => e.AssessmentId)
                .ValueGeneratedNever()
                .HasColumnName("AssessmentID");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.Criteria)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("criteria");
            entity.Property(e => e.Description)
                .HasMaxLength(1000)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.ModuleId).HasColumnName("ModuleID");
            entity.Property(e => e.PassingMarks).HasColumnName("passing_marks");
            entity.Property(e => e.Title)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.TotalMarks).HasColumnName("total_marks");
            entity.Property(e => e.Type)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Weightage).HasColumnName("weightage");

            entity.HasOne(d => d.Course).WithMany(p => p.Assessments)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Assessmen__Cours__5AEE82B9");

            entity.HasOne(d => d.Module).WithMany(p => p.Assessments)
                .HasForeignKey(d => new { d.ModuleId, d.CourseId })
                .HasConstraintName("FK__Assessment__5BE2A6F2");
        });

        modelBuilder.Entity<Badge>(entity =>
        {
            entity.HasKey(e => e.BadgeId).HasName("PK__Badge__1918237C7559F87F");

            entity.ToTable("Badge");

            entity.Property(e => e.BadgeId)
                .ValueGeneratedNever()
                .HasColumnName("BadgeID");
            entity.Property(e => e.Criteria)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("criteria");
            entity.Property(e => e.Description)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Points).HasColumnName("points");
            entity.Property(e => e.Title)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("title");
        });

        modelBuilder.Entity<Collaborative>(entity =>
        {
            entity.HasKey(e => new { e.QuestId, e.Deadline, e.MaxNumParticipants }).HasName("PK__Collabor__F9AE58EAA3361A8E");

            entity.ToTable("Collaborative");

            entity.HasIndex(e => e.QuestId, "UQ__Collabor__B6619ACAF83AAEA7").IsUnique();

            entity.Property(e => e.QuestId).HasColumnName("QuestID");
            entity.Property(e => e.Deadline)
                .HasColumnType("datetime")
                .HasColumnName("deadline");
            entity.Property(e => e.MaxNumParticipants).HasColumnName("Max_num_participants");

            entity.HasOne(d => d.Quest).WithOne(p => p.Collaborative)
                .HasForeignKey<Collaborative>(d => d.QuestId)
                .HasConstraintName("FK__Collabora__Quest__32AB8735");
        });

        modelBuilder.Entity<ContentLibrary>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ContentL__3214EC2748DD1E29");

            entity.ToTable("ContentLibrary");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.ContentUrl)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("content_URL");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.Metadata)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("metadata");
            entity.Property(e => e.ModuleId).HasColumnName("ModuleID");
            entity.Property(e => e.Title)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Type)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("type");

            entity.HasOne(d => d.Module).WithMany(p => p.ContentLibraries)
                .HasForeignKey(d => new { d.ModuleId, d.CourseId })
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__ContentLibrary__5812160E");
        });

        modelBuilder.Entity<Course>(entity =>
        {
            entity.HasKey(e => e.CourseId).HasName("PK__Course__C92D7187F439A35E");

            entity.ToTable("Course");

            entity.Property(e => e.CourseId)
                .ValueGeneratedNever()
                .HasColumnName("CourseID");
            entity.Property(e => e.CreditPoints).HasColumnName("credit_points");
            entity.Property(e => e.Description)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.DifficultyLevel)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("difficulty_level");
            entity.Property(e => e.LearningObjectives)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("Learning_objectives");
            entity.Property(e => e.PreRequisites)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("Pre_requisites");
            entity.Property(e => e.Title)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<CourseEnrollment>(entity =>
        {
            entity.HasKey(e => e.EnrollmentId).HasName("PK__Course_e__7F6877FB9259A200");

            entity.ToTable("Course_enrollment");

            entity.Property(e => e.EnrollmentId)
                .ValueGeneratedNever()
                .HasColumnName("EnrollmentID");
            entity.Property(e => e.CompletionDate).HasColumnName("completion_date");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.EnrollmentDate).HasColumnName("enrollment_date");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");

            entity.HasOne(d => d.Course).WithMany(p => p.CourseEnrollments)
                .HasForeignKey(d => d.CourseId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Course_en__Cours__787EE5A0");

            entity.HasOne(d => d.Learner).WithMany(p => p.CourseEnrollments)
                .HasForeignKey(d => d.LearnerId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Course_en__Learn__797309D9");
        });

        modelBuilder.Entity<CoursePrerequisite>(entity =>
        {
            entity.HasKey(e => new { e.CourseId, e.Prereq }).HasName("PK__CoursePr__F8693C2C9D314350");

            entity.ToTable("CoursePrerequisite");

            entity.Property(e => e.CourseId).HasColumnName("CourseID");

            entity.HasOne(d => d.Course).WithMany(p => p.CoursePrerequisites)
                .HasForeignKey(d => d.CourseId)
                .HasConstraintName("FK__CoursePre__Cours__4AB81AF0");
        });

        modelBuilder.Entity<DiscussionForum>(entity =>
        {
            entity.HasKey(e => e.ForumId).HasName("PK__Discussi__BBA7A4406DFF766E");

            entity.ToTable("Discussion_forum");

            entity.Property(e => e.ForumId).HasColumnName("forumID");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.Description)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.LastActive)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("last_active");
            entity.Property(e => e.ModuleId).HasColumnName("ModuleID");
            entity.Property(e => e.Timestamp)
                .HasColumnType("datetime")
                .HasColumnName("timestamp");
            entity.Property(e => e.Title)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("title");

            entity.HasOne(d => d.Course).WithMany(p => p.DiscussionForums)
                .HasForeignKey(d => d.CourseId)
                .HasConstraintName("FK__Discussio__Cours__395884C4");

            entity.HasOne(d => d.Module).WithMany(p => p.DiscussionForums)
                .HasForeignKey(d => new { d.ModuleId, d.CourseId })
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Discussion_forum__3864608B");
        });

        modelBuilder.Entity<EmotionalFeedback>(entity =>
        {
            entity.HasKey(e => e.FeedbackId).HasName("PK__Emotiona__6A4BEDF621C71969");

            entity.ToTable("EmotionalFeedback");

            entity.Property(e => e.FeedbackId).HasColumnName("FeedbackID");
            entity.Property(e => e.ActivityId).HasColumnName("activityID");
            entity.Property(e => e.EmotionalState)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("emotionalState");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Timestamp)
                .HasColumnType("datetime")
                .HasColumnName("timestamp");

            entity.HasOne(d => d.Activity).WithMany(p => p.EmotionalFeedbacks)
                .HasForeignKey(d => d.ActivityId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Emotional__activ__68487DD7");

            entity.HasOne(d => d.Learner).WithMany(p => p.EmotionalFeedbacks)
                .HasForeignKey(d => d.LearnerId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Emotional__Learn__693CA210");
        });

        modelBuilder.Entity<EmotionalfeedbackReview>(entity =>
        {
            entity.HasKey(e => new { e.FeedbackId, e.InstructorId }).HasName("PK__Emotiona__C39BFD41A59FA077");

            entity.ToTable("Emotionalfeedback_review");

            entity.Property(e => e.FeedbackId).HasColumnName("FeedbackID");
            entity.Property(e => e.InstructorId).HasColumnName("InstructorID");
            entity.Property(e => e.Feedback)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("feedback");

            entity.HasOne(d => d.FeedbackNavigation).WithMany(p => p.EmotionalfeedbackReviews)
                .HasForeignKey(d => d.FeedbackId)
                .HasConstraintName("FK__Emotional__Feedb__74AE54BC");

            entity.HasOne(d => d.Instructor).WithMany(p => p.EmotionalfeedbackReviews)
                .HasForeignKey(d => d.InstructorId)
                .HasConstraintName("FK__Emotional__Instr__75A278F5");
        });

        modelBuilder.Entity<FilledSurvey>(entity =>
        {
            entity.HasKey(e => new { e.SurveyId, e.Question, e.LearnerId }).HasName("PK__FilledSu__D89C33C7B2B05FA7");

            entity.ToTable("FilledSurvey");

            entity.Property(e => e.SurveyId).HasColumnName("SurveyID");
            entity.Property(e => e.Question)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Answer)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.Learner).WithMany(p => p.FilledSurveys)
                .HasForeignKey(d => d.LearnerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__FilledSur__Learn__17F790F9");

            entity.HasOne(d => d.SurveyQuestion).WithMany(p => p.FilledSurveys)
                .HasForeignKey(d => new { d.SurveyId, d.Question })
                .HasConstraintName("FK__FilledSurvey__17036CC0");
        });

        modelBuilder.Entity<HealthCondtion>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.ProfileId, e.Condition }).HasName("PK__HealthCo__930320B0B6FA6EDB");

            entity.ToTable("HealthCondtion");

            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.ProfileId).HasColumnName("ProfileID");
            entity.Property(e => e.Condition)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("condition");

            entity.HasOne(d => d.PersonalizationProfile).WithMany(p => p.HealthCondtions)
                .HasForeignKey(d => new { d.LearnerId, d.ProfileId })
                .HasConstraintName("FK__HealthCondtion__45F365D3");
        });

        modelBuilder.Entity<Instructor>(entity =>
        {
            entity.HasKey(e => e.InstructorId).HasName("PK__Instruct__9D010B7B5D12F45B");

            entity.ToTable("Instructor");

            entity.Property(e => e.InstructorId)
                .ValueGeneratedNever()
                .HasColumnName("InstructorID");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.ExpertiseArea)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("expertise_area");
            entity.Property(e => e.LatestQualification)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("latest_qualification");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");

            entity.HasMany(d => d.Courses).WithMany(p => p.Instructors)
                .UsingEntity<Dictionary<string, object>>(
                    "Teach",
                    r => r.HasOne<Course>().WithMany()
                        .HasForeignKey("CourseId")
                        .HasConstraintName("FK__Teaches__CourseI__7D439ABD"),
                    l => l.HasOne<Instructor>().WithMany()
                        .HasForeignKey("InstructorId")
                        .HasConstraintName("FK__Teaches__Instruc__7C4F7684"),
                    j =>
                    {
                        j.HasKey("InstructorId", "CourseId").HasName("PK__Teaches__F193DC6371E827FD");
                        j.ToTable("Teaches");
                        j.IndexerProperty<int>("InstructorId").HasColumnName("InstructorID");
                        j.IndexerProperty<int>("CourseId").HasColumnName("CourseID");
                    });
        });

        modelBuilder.Entity<InteractionLog>(entity =>
        {
            entity.HasKey(e => e.LogId).HasName("PK__Interact__5E5499A8038F4670");

            entity.ToTable("Interaction_log");

            entity.Property(e => e.LogId)
                .ValueGeneratedNever()
                .HasColumnName("LogID");
            entity.Property(e => e.ActionType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("action_type");
            entity.Property(e => e.ActivityId).HasColumnName("activity_ID");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Timestamp).HasColumnType("datetime");

            entity.HasOne(d => d.Activity).WithMany(p => p.InteractionLogs)
                .HasForeignKey(d => d.ActivityId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Interacti__activ__6477ECF3");

            entity.HasOne(d => d.Learner).WithMany(p => p.InteractionLogs)
                .HasForeignKey(d => d.LearnerId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Interacti__Learn__656C112C");
        });

        modelBuilder.Entity<Leaderboard>(entity =>
        {
            entity.HasKey(e => e.LeaderboardId).HasName("PK__Leaderbo__B358A1E62C747F7D");

            entity.ToTable("Leaderboard");

            entity.Property(e => e.LeaderboardId)
                .ValueGeneratedNever()
                .HasColumnName("LeaderboardID");
            entity.Property(e => e.Season)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("season");
        });

        modelBuilder.Entity<Learner>(entity =>
        {
            entity.HasKey(e => e.LearnerId).HasName("PK__Learner__67ABFCFA0982C2A5");

            entity.ToTable("Learner");

            entity.Property(e => e.LearnerId)
                .ValueGeneratedNever()
                .HasColumnName("LearnerID");
            entity.Property(e => e.BirthDate)
                .HasColumnType("datetime")
                .HasColumnName("birth_date");
            entity.Property(e => e.Country)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("country");
            entity.Property(e => e.CulturalBackground)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("cultural_background");
            entity.Property(e => e.Email)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.FirstName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("first_name");
            entity.Property(e => e.Gender)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.LastName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("last_name");
        });

        modelBuilder.Entity<LearnerDiscussion>(entity =>
        {
            entity.HasKey(e => new { e.ForumId, e.LearnerId, e.Post }).HasName("PK__LearnerD__FBCECC4AF6233B10");

            entity.ToTable("LearnerDiscussion");

            entity.Property(e => e.ForumId).HasColumnName("ForumID");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Post)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.Time)
                .HasColumnType("datetime")
                .HasColumnName("time");

            entity.HasOne(d => d.Forum).WithMany(p => p.LearnerDiscussions)
                .HasForeignKey(d => d.ForumId)
                .HasConstraintName("FK__LearnerDi__Forum__3C34F16F");

            entity.HasOne(d => d.Learner).WithMany(p => p.LearnerDiscussions)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__LearnerDi__Learn__3D2915A8");
        });

        modelBuilder.Entity<LearnersCollaboration>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.QuestId }).HasName("PK__Learners__CCCDE5563C49980A");

            entity.ToTable("LearnersCollaboration");

            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.QuestId).HasColumnName("QuestID");
            entity.Property(e => e.CompletionStatus)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Learner).WithMany(p => p.LearnersCollaborations)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__LearnersC__Learn__40058253");

            entity.HasOne(d => d.Quest).WithMany(p => p.LearnersCollaborations)
                .HasPrincipalKey(p => p.QuestId)
                .HasForeignKey(d => d.QuestId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__LearnersC__Quest__40F9A68C");
        });

        modelBuilder.Entity<LearnersMastery>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.QuestId }).HasName("PK__Learners__CCCDE556FF2803AC");

            entity.ToTable("LearnersMastery");

            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.QuestId).HasColumnName("QuestID");
            entity.Property(e => e.CompletionStatus)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Learner).WithMany(p => p.LearnersMasteries)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__LearnersM__Learn__43D61337");

            entity.HasOne(d => d.Quest).WithMany(p => p.LearnersMasteries)
                .HasForeignKey(d => d.QuestId)
                .HasConstraintName("FK__LearnersM__Quest__44CA3770");
        });

        modelBuilder.Entity<LearningActivity>(entity =>
        {
            entity.HasKey(e => e.ActivityId).HasName("PK__Learning__45F4A7F1AF855DA9");

            entity.ToTable("Learning_activities");

            entity.Property(e => e.ActivityId)
                .ValueGeneratedNever()
                .HasColumnName("ActivityID");
            entity.Property(e => e.ActivityType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("activity_type");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.InstructionDetails)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("instruction_details");
            entity.Property(e => e.MaxPoints).HasColumnName("Max_points");
            entity.Property(e => e.ModuleId).HasColumnName("ModuleID");

            entity.HasOne(d => d.Module).WithMany(p => p.LearningActivities)
                .HasForeignKey(d => new { d.ModuleId, d.CourseId })
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Learning_activit__619B8048");
        });

        modelBuilder.Entity<LearningGoal>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Learning__3214EC272EE196A3");

            entity.ToTable("Learning_goal");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Deadline).HasColumnName("deadline");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");

            entity.HasMany(d => d.Learners).WithMany(p => p.Goals)
                .UsingEntity<Dictionary<string, object>>(
                    "LearnersGoal",
                    r => r.HasOne<Learner>().WithMany()
                        .HasForeignKey("LearnerId")
                        .HasConstraintName("FK__LearnersG__Learn__0E6E26BF"),
                    l => l.HasOne<LearningGoal>().WithMany()
                        .HasForeignKey("GoalId")
                        .HasConstraintName("FK__LearnersG__GoalI__0D7A0286"),
                    j =>
                    {
                        j.HasKey("GoalId", "LearnerId").HasName("PK__Learners__3C3540FE758D694A");
                        j.ToTable("LearnersGoals");
                        j.IndexerProperty<int>("GoalId").HasColumnName("GoalID");
                        j.IndexerProperty<int>("LearnerId").HasColumnName("LearnerID");
                    });
        });

        modelBuilder.Entity<LearningGoalProgress>(entity =>
        {
            entity.HasKey(e => e.ProgressId).HasName("PK__Learning__BAE29C85CBE1C742");

            entity.ToTable("LearningGoalProgress");

            entity.Property(e => e.ProgressId).HasColumnName("ProgressID");
            entity.Property(e => e.GoalId).HasColumnName("GoalID");
            entity.Property(e => e.LastUpdated)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Goal).WithMany(p => p.LearningGoalProgresses)
                .HasForeignKey(d => d.GoalId)
                .HasConstraintName("FK__LearningG__GoalI__09A971A2");

            entity.HasOne(d => d.Learner).WithMany(p => p.LearningGoalProgresses)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__LearningG__Learn__0A9D95DB");
        });

        modelBuilder.Entity<LearningPath>(entity =>
        {
            entity.HasKey(e => e.PathId).HasName("PK__Learning__BFB8200ACC73FFAF");

            entity.ToTable("Learning_path");

            entity.Property(e => e.PathId)
                .ValueGeneratedNever()
                .HasColumnName("pathID");
            entity.Property(e => e.AdaptiveRules)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("adaptive_rules");
            entity.Property(e => e.CompletionStatus)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("completion_status");
            entity.Property(e => e.CustomContent)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("custom_content");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.ProfileId).HasColumnName("ProfileID");

            entity.HasOne(d => d.PersonalizationProfile).WithMany(p => p.LearningPaths)
                .HasForeignKey(d => new { d.LearnerId, d.ProfileId })
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Learning_path__6C190EBB");
        });

        modelBuilder.Entity<LearningPreference>(entity =>
        {
            entity.HasKey(e => new { e.Preference, e.LearnerId }).HasName("PK__learning__CFEB65EE6DA26E16");

            entity.ToTable("learning_preferences");

            entity.Property(e => e.Preference).HasColumnName("preference");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");

            entity.HasOne(d => d.Learner).WithMany(p => p.LearningPreferences)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__learning___Learn__403A8C7D");
        });

        modelBuilder.Entity<Module>(entity =>
        {
            entity.HasKey(e => new { e.ModuleId, e.CourseId }).HasName("PK__Module__47E6A09FD193BD4C");

            entity.ToTable("Module");

            entity.Property(e => e.ModuleId).HasColumnName("ModuleID");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.ContentUrl)
                .HasMaxLength(1000)
                .IsUnicode(false)
                .HasColumnName("contentURL");
            entity.Property(e => e.DifficultyLevel)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("difficulty_Level");
            entity.Property(e => e.Title)
                .HasMaxLength(100)
                .IsUnicode(false);

            entity.HasOne(d => d.Course).WithMany(p => p.Modules)
                .HasForeignKey(d => d.CourseId)
                .HasConstraintName("FK__Module__CourseID__4D94879B");
        });

        modelBuilder.Entity<ModuleContent>(entity =>
        {
            entity.HasKey(e => new { e.ModuleId, e.CourseId, e.ContentType }).HasName("PK__ModuleCo__402E75DACD4C18FF");

            entity.ToTable("ModuleContent");

            entity.Property(e => e.ModuleId).HasColumnName("ModuleID");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.ContentType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("content_type");

            entity.HasOne(d => d.Course).WithMany(p => p.ModuleContents)
                .HasForeignKey(d => d.CourseId)
                .HasConstraintName("FK__ModuleCon__Cours__5535A963");

            entity.HasOne(d => d.Module).WithMany(p => p.ModuleContents)
                .HasForeignKey(d => new { d.ModuleId, d.CourseId })
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ModuleContent__5441852A");
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasKey(e => e.NotificationId).HasName("PK__Notifica__20CF2E32289EED49");

            entity.ToTable("Notification");

            entity.Property(e => e.NotificationId)
                .ValueGeneratedNever()
                .HasColumnName("NotificationID");
            entity.Property(e => e.Message)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("message");
            entity.Property(e => e.ReadStatus).HasDefaultValue(false);
            entity.Property(e => e.Timestamp)
                .IsRowVersion()
                .IsConcurrencyToken()
                .HasColumnName("timestamp");
            entity.Property(e => e.UrgencyLevel)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("urgency_level");
        });

        modelBuilder.Entity<Pathreview>(entity =>
        {
            entity.HasKey(e => new { e.InstructorId, e.PathId }).HasName("PK__Pathrevi__11D776B86E431439");

            entity.ToTable("Pathreview");

            entity.Property(e => e.InstructorId).HasColumnName("InstructorID");
            entity.Property(e => e.PathId).HasColumnName("PathID");
            entity.Property(e => e.Feedback)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("feedback");

            entity.HasOne(d => d.Instructor).WithMany(p => p.Pathreviews)
                .HasForeignKey(d => d.InstructorId)
                .HasConstraintName("FK__Pathrevie__Instr__70DDC3D8");

            entity.HasOne(d => d.Path).WithMany(p => p.Pathreviews)
                .HasForeignKey(d => d.PathId)
                .HasConstraintName("FK__Pathrevie__PathI__71D1E811");
        });

        modelBuilder.Entity<PersonalizationProfile>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.ProfileId }).HasName("PK__Personal__353B3472D7378147");

            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.ProfileId).HasColumnName("ProfileID");
            entity.Property(e => e.EmotionalState)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("emotional_state");
            entity.Property(e => e.PersonalityType)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("personality_type");
            entity.Property(e => e.PreferedContentType)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("prefered_content_type");

            entity.HasOne(d => d.Learner).WithMany(p => p.PersonalizationProfiles)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__Personali__Learn__4316F928");
        });

        modelBuilder.Entity<Quest>(entity =>
        {
            entity.HasKey(e => e.QuestId).HasName("PK__Quest__B6619ACB6F5BFC25");

            entity.ToTable("Quest");

            entity.Property(e => e.QuestId)
                .ValueGeneratedNever()
                .HasColumnName("QuestID");
            entity.Property(e => e.Criteria)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("criteria");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.DifficultyLevel)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("difficulty_level");
            entity.Property(e => e.Title)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("title");

            entity.HasMany(d => d.Learners).WithMany(p => p.Quests)
                .UsingEntity<Dictionary<string, object>>(
                    "SkillMastery",
                    r => r.HasOne<Learner>().WithMany()
                        .HasForeignKey("LearnerId")
                        .HasConstraintName("FK__skill_Mas__Learn__2EDAF651"),
                    l => l.HasOne<Quest>().WithMany()
                        .HasForeignKey("QuestId")
                        .HasConstraintName("FK__skill_Mas__Quest__2DE6D218"),
                    j =>
                    {
                        j.HasKey("QuestId", "LearnerId").HasName("PK__skill_Ma__001B250484B6E360");
                        j.ToTable("skill_Mastery");
                        j.IndexerProperty<int>("QuestId").HasColumnName("QuestID");
                        j.IndexerProperty<int>("LearnerId").HasColumnName("LearnerID");
                    });
        });

        modelBuilder.Entity<QuestReward>(entity =>
        {
            entity.HasKey(e => new { e.RewardId, e.QuestId, e.LearnerId }).HasName("PK__QuestRew__D251A7C9B76A7F34");

            entity.ToTable("QuestReward");

            entity.Property(e => e.RewardId).HasColumnName("RewardID");
            entity.Property(e => e.QuestId).HasColumnName("QuestID");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.TimeEarned).HasColumnName("Time_earned");

            entity.HasOne(d => d.Learner).WithMany(p => p.QuestRewards)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__QuestRewa__Learn__498EEC8D");

            entity.HasOne(d => d.Quest).WithMany(p => p.QuestRewards)
                .HasForeignKey(d => d.QuestId)
                .HasConstraintName("FK__QuestRewa__Quest__489AC854");

            entity.HasOne(d => d.Reward).WithMany(p => p.QuestRewards)
                .HasForeignKey(d => d.RewardId)
                .HasConstraintName("FK__QuestRewa__Rewar__47A6A41B");
        });

        modelBuilder.Entity<Ranking>(entity =>
        {
            entity.HasKey(e => new { e.LeaderboardId, e.LearnerId, e.CourseId }).HasName("PK__Ranking__83EB3358BBF03B69");

            entity.ToTable("Ranking");

            entity.Property(e => e.LeaderboardId).HasColumnName("LeaderboardID");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.Rank).HasColumnName("rank");
            entity.Property(e => e.TotalPoints).HasColumnName("total_points");

            entity.HasOne(d => d.Course).WithMany(p => p.Rankings)
                .HasForeignKey(d => d.CourseId)
                .HasConstraintName("FK__Ranking__CourseI__03F0984C");

            entity.HasOne(d => d.Leaderboard).WithMany(p => p.Rankings)
                .HasForeignKey(d => d.LeaderboardId)
                .HasConstraintName("FK__Ranking__Leaderb__02084FDA");

            entity.HasOne(d => d.Learner).WithMany(p => p.Rankings)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__Ranking__Learner__02FC7413");
        });

        modelBuilder.Entity<ReceivedNotification>(entity =>
        {
            entity.HasKey(e => new { e.NotificationId, e.LearnerId }).HasName("PK__Received__96B591FDED9529C1");

            entity.ToTable("ReceivedNotification");

            entity.Property(e => e.NotificationId).HasColumnName("NotificationID");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.ReadStatus).HasDefaultValue(false);

            entity.HasOne(d => d.Learner).WithMany(p => p.ReceivedNotifications)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__ReceivedN__Learn__1EA48E88");

            entity.HasOne(d => d.Notification).WithMany(p => p.ReceivedNotifications)
                .HasForeignKey(d => d.NotificationId)
                .HasConstraintName("FK__ReceivedN__Notif__1DB06A4F");
        });

        modelBuilder.Entity<Reward>(entity =>
        {
            entity.HasKey(e => e.RewardId).HasName("PK__Reward__82501599168D317F");

            entity.ToTable("Reward");

            entity.Property(e => e.RewardId)
                .ValueGeneratedNever()
                .HasColumnName("RewardID");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.Type)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("type");
            entity.Property(e => e.Value)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("value");
        });

        modelBuilder.Entity<Skill>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.SkillName }).HasName("PK__skills__B097FF7012437CA5");

            entity.ToTable("skills");

            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.SkillName)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("skill_name");

            entity.HasOne(d => d.Learner).WithMany(p => p.Skills)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__skills__LearnerI__3D5E1FD2");
        });

        modelBuilder.Entity<SkillMasterySkill>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.Skills }).HasName("PK__Skill_Ma__5E14C14AEBA6B7FC");

            entity.ToTable("Skill_Mastery_Skill");

            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.Skills)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.Learner).WithMany(p => p.SkillMasterySkills)
                .HasForeignKey(d => d.LearnerId)
                .HasConstraintName("FK__Skill_Mas__Learn__3587F3E0");
        });

        modelBuilder.Entity<SkillProgression>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__SkillPro__3213E83FF71C79AC");

            entity.ToTable("SkillProgression");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("id");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.ProficiencyLevel)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("proficiency_level");
            entity.Property(e => e.Skill)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("skill");
            entity.Property(e => e.Timestamp)
                .HasColumnType("datetime")
                .HasColumnName("timestamp");

            entity.HasOne(d => d.SkillNavigation).WithMany(p => p.SkillProgressions)
                .HasForeignKey(d => new { d.LearnerId, d.Skill })
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__SkillProgression__236943A5");
        });

        modelBuilder.Entity<Survey>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Survey__3214EC27FD979ADE");

            entity.ToTable("Survey");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Title)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<SurveyQuestion>(entity =>
        {
            entity.HasKey(e => new { e.SurveyId, e.Question }).HasName("PK__SurveyQu__23FB983BFB9C7BF2");

            entity.Property(e => e.SurveyId).HasColumnName("SurveyID");
            entity.Property(e => e.Question)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Answer)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");

            entity.HasOne(d => d.Learner).WithMany(p => p.SurveyQuestions)
                .HasForeignKey(d => d.LearnerId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__SurveyQue__Learn__1332DBDC");

            entity.HasOne(d => d.Survey).WithMany(p => p.SurveyQuestions)
                .HasForeignKey(d => d.SurveyId)
                .HasConstraintName("FK__SurveyQue__Surve__14270015");
        });

        modelBuilder.Entity<Takenassessment>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable("Takenassessment");

            entity.Property(e => e.AssessmentId).HasColumnName("AssessmentID");
            entity.Property(e => e.LearnerId).HasColumnName("LearnerID");
            entity.Property(e => e.ScoredPoint).HasColumnName("scoredPoint");

            entity.HasOne(d => d.Assessment).WithMany()
                .HasForeignKey(d => d.AssessmentId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Takenasse__Asses__5DCAEF64");

            entity.HasOne(d => d.Learner).WithMany()
                .HasForeignKey(d => d.LearnerId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Takenasse__Learn__5EBF139D");
        });

        modelBuilder.Entity<TargetTrait>(entity =>
        {
            entity.HasKey(e => new { e.ModuleId, e.CourseId, e.Trait }).HasName("PK__Target_t__4E005E4C03162570");

            entity.ToTable("Target_traits");

            entity.Property(e => e.ModuleId).HasColumnName("ModuleID");
            entity.Property(e => e.CourseId).HasColumnName("CourseID");
            entity.Property(e => e.Trait)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Course).WithMany(p => p.TargetTraits)
                .HasForeignKey(d => d.CourseId)
                .HasConstraintName("FK__Target_tr__Cours__5165187F");

            entity.HasOne(d => d.Module).WithMany(p => p.TargetTraits)
                .HasForeignKey(d => new { d.ModuleId, d.CourseId })
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Target_traits__5070F446");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Username).HasName("PK__Users__F3DBC57362EE1F4A");

            entity.HasIndex(e => e.Email, "UQ__Users__AB6E61646FA1E973").IsUnique();

            entity.Property(e => e.Username).HasColumnName("username");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .HasColumnName("email");
            entity.Property(e => e.FullName)
                .HasMaxLength(255)
                .HasColumnName("full_name");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .HasColumnName("password");
            entity.Property(e => e.ProfilePicture).HasColumnName("profile_picture");
            entity.Property(e => e.ProfilePicture1)
                .HasMaxLength(255)
                .HasColumnName("ProfilePicture");
            entity.Property(e => e.UpdatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
            entity.Property(e => e.UserType)
                .HasMaxLength(50)
                .HasColumnName("user_type");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
