using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class LearningGoalProgress
{
    public int ProgressId { get; set; }

    public int? GoalId { get; set; }

    public int? LearnerId { get; set; }

    public string? Status { get; set; }

    public DateTime? LastUpdated { get; set; }

    public virtual LearningGoal? Goal { get; set; }

    public virtual Learner? Learner { get; set; }
}
