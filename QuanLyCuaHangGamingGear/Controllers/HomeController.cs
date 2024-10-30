using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using QuanLyCuaHangGamingGear.Models;
using System.Diagnostics;

namespace QuanLyCuaHangGamingGear.Controllers
{
	public class HomeController : Controller
	{
		private readonly DbGearshopContext _context;

		public HomeController(DbGearshopContext context)
		{
			_context = context;
		}
		public ActionResult Chatbot()
		{
			return View();
		}
		public IActionResult Index()
		{
			return View(_context.SanPhams.Include(s => s.MaLoaiSpNavigation).Include(s => s.MaHangSxNavigation).ToList());
		}

		public IActionResult Privacy()
		{
			return View();
		}

		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
		public IActionResult Error()
		{
			return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
		}
	}
}