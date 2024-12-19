﻿using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class HealthCondtion
{
    public int LearnerId { get; set; }

    public int ProfileId { get; set; }

    public string Condition { get; set; } = null!;

    public virtual PersonalizationProfile PersonalizationProfile { get; set; } = null!;
}