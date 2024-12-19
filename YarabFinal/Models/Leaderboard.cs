﻿using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class Leaderboard
{
    public int LeaderboardId { get; set; }

    public string? Season { get; set; }

    public virtual ICollection<Ranking> Rankings { get; set; } = new List<Ranking>();
}
