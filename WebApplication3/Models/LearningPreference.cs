﻿using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class LearningPreference
{
    public int Preference { get; set; }

    public int LearnerId { get; set; }

    public virtual Learner Learner { get; set; } = null!;
}