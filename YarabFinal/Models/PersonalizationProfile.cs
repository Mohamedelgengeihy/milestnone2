using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class PersonalizationProfile
{
    public int LearnerId { get; set; }

    public int ProfileId { get; set; }

    public string? PreferedContentType { get; set; }

    public string? EmotionalState { get; set; }

    public string? PersonalityType { get; set; }

    public virtual ICollection<HealthCondtion> HealthCondtions { get; set; } = new List<HealthCondtion>();

    public virtual Learner Learner { get; set; } = null!;

    public virtual ICollection<LearningPath> LearningPaths { get; set; } = new List<LearningPath>();
}
