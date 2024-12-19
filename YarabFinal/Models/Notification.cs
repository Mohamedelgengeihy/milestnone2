using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class Notification
{
    public int NotificationId { get; set; }

    public byte[] Timestamp { get; set; } = null!;

    public string? Message { get; set; }

    public string? UrgencyLevel { get; set; }

    public bool? ReadStatus { get; set; }

    public virtual ICollection<ReceivedNotification> ReceivedNotifications { get; set; } = new List<ReceivedNotification>();
}
