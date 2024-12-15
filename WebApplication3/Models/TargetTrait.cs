using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class TargetTrait
{
    public int ModuleId { get; set; }

    public int CourseId { get; set; }

    public string Trait { get; set; } = null!;

    public virtual Course Course { get; set; } = null!;

    public virtual Module Module { get; set; } = null!;
}
