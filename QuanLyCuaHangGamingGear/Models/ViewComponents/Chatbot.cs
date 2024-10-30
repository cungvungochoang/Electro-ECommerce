using Microsoft.AspNetCore.Mvc;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
	public class Chatbot : ViewComponent
	{
		public IViewComponentResult Invoke()
		{
			return View();
		}
	}
}