using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace QuanLyCuaHangGamingGear.Models;

public partial class PhieuNhap
{
    public int MaPn { get; set; }
	public int? MaNcc { get; set; }

	[Display(Name = "Nhân viên phụ trách")]
	public int? MaNv { get; set; }

	[Display(Name = "Ngày nhập")]
	public DateTime NgayNhap { get; set; }

	[Display(Name = "Tổng thành tiền")]
	public decimal? TongTienPn { get; set; }

	[Display(Name = "Ghi chú")]
	public string? GhiChu { get; set; }

    public virtual ICollection<ChiTietPhieuNhap> ChiTietPhieuNhaps { get; } = new List<ChiTietPhieuNhap>();

    public virtual NhaCungCap? MaNccNavigation { get; set; }

    public virtual NhanVien? MaNvNavigation { get; set; }
}
