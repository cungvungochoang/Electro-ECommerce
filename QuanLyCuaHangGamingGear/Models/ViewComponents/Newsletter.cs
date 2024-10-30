using Microsoft.AspNetCore.Mvc;

namespace QuanLyCuaHangGamingGear.Models.ViewComponents
{
    public class Newsletter : ViewComponent
    {
        public IViewComponentResult Invoke()
        {
            return View();
        }
    }
}
