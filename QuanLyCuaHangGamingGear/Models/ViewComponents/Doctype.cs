using Microsoft.AspNetCore.Mvc;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
	public class Doctype : ViewComponent
	{
		public IViewComponentResult Invoke()
		{
			return View();
		}
	}
}