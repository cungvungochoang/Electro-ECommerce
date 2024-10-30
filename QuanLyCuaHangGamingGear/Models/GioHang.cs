namespace QuanLyCuaHangGamingGear.Models
{
	public class GioHang
	{
		public int MaSP { get; set; }
		public string TenSP { get; set; }
		public string HinhAnh { get; set; }
		public decimal DonGia { get; set; }
		public int SoLuong { get; set; }
		public decimal ThanhTien => SoLuong * DonGia;
	}
}
