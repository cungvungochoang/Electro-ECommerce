using Microsoft.AspNetCore.Mvc;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
    public class Navbar : ViewComponent
    {
        private readonly DbGearshopContext _context;

        public Navbar(DbGearshopContext context)
        {
            _context = context;
        }
        public IViewComponentResult Invoke()
        {
            return View(_context.LoaiSps.ToList());
        }
    }
}
