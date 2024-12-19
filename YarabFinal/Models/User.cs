using System;
using System.Collections.Generic;

namespace YarabFinal.Models;

public partial class User
{
    public int Username { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string? FullName { get; set; }

    public string UserType { get; set; } = null!;

    public string? ProfilePicture { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public string? ProfilePicture1 { get; set; }

    public virtual ICollection<Admin1> Admin1s { get; set; } = new List<Admin1>();
}
