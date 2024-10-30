using Microsoft.AspNetCore.Mvc;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
	public class Header : ViewComponent
	{
		public IViewComponentResult Invoke()
		{
			return View();
		}
	}
}
