using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class SkillProgression
{
    public int Id { get; set; }

    public string? ProficiencyLevel { get; set; }

    public int? LearnerId { get; set; }

    public string? Skill { get; set; }

    public DateTime? Timestamp { get; set; }

    public virtual Skill? SkillNavigation { get; set; }
}
