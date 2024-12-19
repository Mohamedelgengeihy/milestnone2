using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class Takenassessment
{
    public int? AssessmentId { get; set; }

    public int? LearnerId { get; set; }

    public int? ScoredPoint { get; set; }

    public virtual Assessment? Assessment { get; set; }

    public virtual Learner? Learner { get; set; }
}
