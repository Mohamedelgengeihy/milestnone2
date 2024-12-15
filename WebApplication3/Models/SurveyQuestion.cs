using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class SurveyQuestion
{
    public int SurveyId { get; set; }

    public string Question { get; set; } = null!;

    public int? LearnerId { get; set; }

    public string? Answer { get; set; }

    public virtual ICollection<FilledSurvey> FilledSurveys { get; set; } = new List<FilledSurvey>();

    public virtual Learner? Learner { get; set; }

    public virtual Survey Survey { get; set; } = null!;
}
