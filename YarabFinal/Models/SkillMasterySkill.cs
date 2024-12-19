using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class SkillMasterySkill
{
    public int LearnerId { get; set; }

    public string Skills { get; set; } = null!;

    public virtual Learner Learner { get; set; } = null!;
}
