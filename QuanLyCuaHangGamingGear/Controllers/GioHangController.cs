using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QuanLyCuaHangGamingGear.Helper;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Controllers
{
	public class GioHangController : Controller
	{
		private readonly DbGearshopContext _context;
		public GioHangController(DbGearshopContext context)
		{
			_context = context;

		}
		public IActionResult Index()
		{
			int slgh = GioHangs.Sum(item => item.SoLuong);
			HttpContext.Session.SetInt32("SoLuongGioHang", slgh);
			return View(GioHangs);
		}
		public List<GioHang> GioHangs
		{
			get
			{
				var data = HttpContext.Session.Get<List<GioHang>>("GioHang");
				if (data == null)
				{
					data = new List<GioHang>();
				}
				return data;
			}
		}
		public IActionResult AddToCart(int id, int quantity)
		{
			var myCart = GioHangs;
			var item = myCart.SingleOrDefault(p => p.MaSP == id);
			if (item == null)
			{
				var sp = _context.SanPhams.SingleOrDefault(p => p.MaSp == id);
				item = new GioHang
				{
					MaSP = id,
					TenSP = sp.TenSp,
					DonGia = (decimal)sp.GiaSp,
					SoLuong = quantity,
					HinhAnh = sp.HinhAnh
				};
				myCart.Add(item);
			}
			else
			{
				item.SoLuong += quantity;
			}
			HttpContext.Session.Set("GioHang", myCart);

			return RedirectToAction("Index");
		}
		public IActionResult RemoveFromCart(int id)
		{
			var myCart = GioHangs;
			var item = myCart.SingleOrDefault(p => p.MaSP == id);

			if (item != null)
			{
				myCart.Remove(item);
				HttpContext.Session.Set("GioHang", myCart);
			}

			return RedirectToAction("Index");
		}
	}
}
