using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class Ranking
{
    public int LeaderboardId { get; set; }

    public int LearnerId { get; set; }

    public int CourseId { get; set; }

    public int? Rank { get; set; }

    public int? TotalPoints { get; set; }

    public virtual Course Course { get; set; } = null!;

    public virtual Leaderboard Leaderboard { get; set; } = null!;

    public virtual Learner Learner { get; set; } = null!;
}
