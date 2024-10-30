using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class KhachHang
{
    public int MaKh { get; set; }
	[Display(Name = "Tên khách hàng")]

	public string? TenKh { get; set; }
	[Display(Name = "Địa chỉ")]
	public string? DiaChi { get; set; }
	[Display(Name = "Số điện thoại")]
	public string? DienThoai { get; set; }
	[Display(Name = "Địa chỉ email")]
	public string? Email { get; set; }
	[Display(Name = "Mật khẩu")]
	public string? MatKhau { get; set; }
	[Display(Name = "Ghi chú")]
	public string? GhiChu { get; set; }

    public virtual ICollection<DonHang> DonHangs { get; } = new List<DonHang>();
}
