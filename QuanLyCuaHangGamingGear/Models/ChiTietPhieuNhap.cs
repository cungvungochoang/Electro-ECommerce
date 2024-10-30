using System;
using System.Collections.Generic;

namespace QuanLyCuaHangGamingGear.Models;

public partial class ChiTietPhieuNhap
{
    public int MaPn { get; set; }

    public int MaSp { get; set; }

    public int? SoLuongSp { get; set; }

    public decimal GiaNhapSp { get; set; }

    public decimal? TongTienNhapSp { get; set; }

    public string? GhiChu { get; set; }

    public virtual PhieuNhap MaPnNavigation { get; set; } = null!;

    public virtual SanPham MaSpNavigation { get; set; } = null!;
}
