using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class SanPham
{
    public int MaSp { get; set; }
	[Display(Name = "Tên sản phẩm")]
	public string? TenSp { get; set; }
	[Display(Name = "Loại sản phẩm")]
	public int? MaLoaiSp { get; set; }
	[Display(Name = "Hãng sản xuất")]
	public int? MaHangSx { get; set; }
	[Display(Name = "Hình ảnh sản phẩm")]
	public string? HinhAnh { get; set; }
	[Display(Name = "Giá sản phẩm")]
	public decimal? GiaSp { get; set; }
	[Display(Name = "Số lượng sản phẩm")]
	public int? SoLuong { get; set; }
	[Display(Name = "Mô tả sản phẩm")]
	public string? MoTa { get; set; }

    public virtual ICollection<ChiTietPhieuNhap> ChiTietPhieuNhaps { get; } = new List<ChiTietPhieuNhap>();

    public virtual ICollection<DonHang> DonHangs { get; } = new List<DonHang>();

    public virtual HangSx? MaHangSxNavigation { get; set; }

    public virtual LoaiSp? MaLoaiSpNavigation { get; set; }
}
