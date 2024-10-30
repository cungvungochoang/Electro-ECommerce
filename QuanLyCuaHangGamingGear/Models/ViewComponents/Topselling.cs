using Microsoft.AspNetCore.Mvc;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
	public class Topselling : ViewComponent
	{
		public IViewComponentResult Invoke()
		{
			return View();
		}
	}
}
