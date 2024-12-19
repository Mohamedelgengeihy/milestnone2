using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class Assessment
{
    public int AssessmentId { get; set; }

    public int? TotalMarks { get; set; }

    public int? CourseId { get; set; }

    public int? ModuleId { get; set; }

    public int? PassingMarks { get; set; }

    public string? Criteria { get; set; }

    public int? Weightage { get; set; }

    public string? Type { get; set; }

    public string? Title { get; set; }

    public string? Description { get; set; }

    public virtual Course? Course { get; set; }

    public virtual Module? Module { get; set; }
}
