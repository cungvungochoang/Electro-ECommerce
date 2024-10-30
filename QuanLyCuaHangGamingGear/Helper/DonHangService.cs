using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Helper
{
    public class DonHangService
    {
        private readonly DbGearshopContext _context;

        public DonHangService(DbGearshopContext context)
        {
            _context = context;
        }
        
    }
}
