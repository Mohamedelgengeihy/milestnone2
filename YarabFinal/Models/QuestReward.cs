using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class QuestReward
{
    public int RewardId { get; set; }

    public int QuestId { get; set; }

    public int LearnerId { get; set; }

    public DateOnly? TimeEarned { get; set; }

    public virtual Learner Learner { get; set; } = null!;

    public virtual Quest Quest { get; set; } = null!;

    public virtual Reward Reward { get; set; } = null!;
}
