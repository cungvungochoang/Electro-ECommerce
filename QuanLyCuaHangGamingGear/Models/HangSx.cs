using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class HangSx
{
    public int MaHangSx { get; set; }
	[Display(Name = "Tên hãng sản xuất")]

	public string? TenHangSx { get; set; }

    public virtual ICollection<SanPham> SanPhams { get; } = new List<SanPham>();
}
