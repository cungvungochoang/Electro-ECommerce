using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class NhaCungCap
{
    public int MaNcc { get; set; }

	[Display(Name = "Tên nhà cung cấp")]
	public string? TenNcc { get; set; }

	[Display(Name = "Địa chỉ")]
	public string? DiaChi { get; set; }

	[Display(Name = "Số điện thoại")]
	public string? DienThoai { get; set; }

	[Display(Name = "Ghi chú")]
	public string? GhiChu { get; set; }

    public virtual ICollection<PhieuNhap> PhieuNhaps { get; } = new List<PhieuNhap>();
}
