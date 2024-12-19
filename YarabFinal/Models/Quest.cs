﻿using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class Quest
{
    public int QuestId { get; set; }

    public string? DifficultyLevel { get; set; }

    public string? Criteria { get; set; }

    public string? Description { get; set; }

    public string? Title { get; set; }

    public virtual Collaborative? Collaborative { get; set; }

    public virtual ICollection<LearnersMastery> LearnersMasteries { get; set; } = new List<LearnersMastery>();

    public virtual ICollection<QuestReward> QuestRewards { get; set; } = new List<QuestReward>();

    public virtual ICollection<Learner> Learners { get; set; } = new List<Learner>();
}
