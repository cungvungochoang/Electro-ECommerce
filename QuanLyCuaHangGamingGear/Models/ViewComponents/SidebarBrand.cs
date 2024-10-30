using Microsoft.AspNetCore.Mvc;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
    public class SidebarBrand : ViewComponent
    {
        private readonly DbGearshopContext _context;

        public SidebarBrand(DbGearshopContext context)
        {
            _context = context;
        }
        public IViewComponentResult Invoke()
        {
            return View(_context.HangSxes.ToList());
        }
    }
}