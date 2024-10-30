using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class HomeController : Controller
	{
        private readonly DbGearshopContext _context;

        public HomeController(DbGearshopContext context)
        {
            _context = context;
        }

        [Route("admin/home/index")]
        public IActionResult Index()
        {
            return View(_context.SanPhams.Include(s => s.MaLoaiSpNavigation).Include(s => s.MaHangSxNavigation).ToList());
        }
    }
}
