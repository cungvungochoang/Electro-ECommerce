using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class NhanVien
{
    public int MaNv { get; set; }

	[Display(Name = "Tên nhân viên")]
	public string? TenNv { get; set; }

	[Display(Name = "Căn cước công dân")]
	public string? Cccd { get; set; }

	[Display(Name = "Địa chỉ")]
	public string? DiaChi { get; set; }

	[Display(Name = "Số điện thoại")]
	public string? DienThoai { get; set; }

	[Display(Name = "Chức vụ")]
	public string? ChucVu { get; set; }

	[Display(Name = "Mật khẩu")]
	public string? MatKhau { get; set; }

	[Display(Name = "Ghi chú")]
	public string? GhiChu { get; set; }

    public virtual ICollection<PhieuNhap> PhieuNhaps { get; } = new List<PhieuNhap>();
}
