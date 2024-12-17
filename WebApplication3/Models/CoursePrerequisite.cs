﻿using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class CoursePrerequisite
{
    public int CourseId { get; set; }

    public int Prereq { get; set; }

    public virtual Course Course { get; set; } = null!;
}