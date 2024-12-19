using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class LearningGoal
{
    public int Id { get; set; }

    public string? Status { get; set; }

    public DateOnly? Deadline { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<LearningGoalProgress> LearningGoalProgresses { get; set; } = new List<LearningGoalProgress>();

    public virtual ICollection<Learner> Learners { get; set; } = new List<Learner>();
}
