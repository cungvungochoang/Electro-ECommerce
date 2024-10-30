using Microsoft.AspNetCore.Mvc;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
    public class Sidebar : ViewComponent
    {
        private readonly DbGearshopContext _context;

        public Sidebar(DbGearshopContext context)
        {
            _context = context;
        }
        public IViewComponentResult Invoke()
        {
            return View(_context.LoaiSps.ToList());
        }
    }
}
