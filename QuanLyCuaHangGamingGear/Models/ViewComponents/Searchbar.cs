using Microsoft.AspNetCore.Mvc;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
    public class Searchbar : ViewComponent
    {
        private readonly DbGearshopContext _context;


        public Searchbar(DbGearshopContext context)
        {
            _context = context;
        }
        public IViewComponentResult Invoke()
        {
            return View(_context.LoaiSps.ToList());
        }
    }
}
