using System;
using System.Collections.Generic;

namespace WebApplication2.Models;

public partial class Admin1
{
    public int AdminId { get; set; }

    public int Username { get; set; }

    public string? Permissions { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual User UsernameNavigation { get; set; } = null!;
}
