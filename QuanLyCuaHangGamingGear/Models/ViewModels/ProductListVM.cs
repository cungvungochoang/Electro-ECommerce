namespace QuanLyCuaHangGamingGear.Models.ViewModels
{
    public class ProductListVM
    {
        public IEnumerable<SanPham> SanPhams { get; set; } = Enumerable.Empty<SanPham>();
        public PagingInfo PagingInfo { get; set; } = new PagingInfo();
    }
}
