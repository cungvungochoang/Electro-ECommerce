using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class LoaiSp
{
    public int MaLoaiSp { get; set; }
	[Display(Name = "Tên loại sản phẩm")]

	public string? TenLoaiSp { get; set; }

    public virtual ICollection<SanPham> SanPhams { get; } = new List<SanPham>();
}
