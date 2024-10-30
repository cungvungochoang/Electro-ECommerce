using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class DonHang
{
    public int MaDh { get; set; }

	[Display(Name = "Mã giao dịch")]
	public string? MaGiaoDich { get; set; }

	[Display(Name = "Tên sản phẩm")]
	public int? MaSp { get; set; }

	[Display(Name = "Số lượng")]
	public int? SoLuongSp { get; set; }

	[Display(Name = "Đơn giá")]
	public decimal? GiaSp { get; set; }

	[Display(Name = "Thành tiền")]
	public decimal? ThanhTien { get; set; }

	[Display(Name = "Tên khách hàng")]
	public int? MaKh { get; set; }

	[Display(Name = "Nhân viên phụ trách")]
	public string TenNvpt { get; set; } = null!;

	[Display(Name = "Ghi chú")]
	public string? GhiChu { get; set; }

    public virtual KhachHang? MaKhNavigation { get; set; }

    public virtual SanPham? MaSpNavigation { get; set; }
}
