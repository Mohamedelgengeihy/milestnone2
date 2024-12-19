using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class ReceivedNotification
{
    public int NotificationId { get; set; }

    public int LearnerId { get; set; }

    public bool? ReadStatus { get; set; }

    public virtual Learner Learner { get; set; } = null!;

    public virtual Notification Notification { get; set; } = null!;
}
