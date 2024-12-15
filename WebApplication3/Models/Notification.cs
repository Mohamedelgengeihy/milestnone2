using System;
using System.Collections.Generic;

namespace WebApplication3.Models;

public partial class Notification
{
    public int NotificationId { get; set; }

    public byte[] Timestamp { get; set; } = null!;

    public string? Message { get; set; }

    public string? UrgencyLevel { get; set; }

    public bool? ReadStatus { get; set; }

    public virtual ICollection<Learner> Learners { get; set; } = new List<Learner>();
}
