using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using QuanLyCuaHangGamingGear.Models;
using Microsoft.AspNetCore.Http;
using System.Transactions;

namespace QuanLyCuaHangGamingGear.Controllers
{
    public class KhachHangsController : Controller
    {
        private readonly DbGearshopContext _context;

        public KhachHangsController(DbGearshopContext context)
        {
            _context = context;
        }
        public IActionResult Login()
        {
            return View();
        }
		public IActionResult Register()
		{
			return View();
		}
		public IActionResult Logout()
		{
			HttpContext.Session.Clear();
			return RedirectToAction("Index", "Home");
		}
		[HttpPost]
        public IActionResult Login(string username, string password)
        {
            var user = _context.KhachHangs.Where(u => u.Email == username && u.MatKhau == password).FirstOrDefault<KhachHang>();
            if (user == null || _context.KhachHangs == null)
            {
                ViewBag.Error = "Tên đăng nhập hoặc mật khẩu không đúng!";
                return View();
            }
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, user.Email)
            }; 
            var claimsIdentity = new ClaimsIdentity(
            claims, CookieAuthenticationDefaults.AuthenticationScheme);
            HttpContext.SignInAsync(
            CookieAuthenticationDefaults.AuthenticationScheme,
            new ClaimsPrincipal(claimsIdentity));
            HttpContext.Session.SetString("UserEmail", user.Email);
            HttpContext.Session.SetString("UserName", user.TenKh);
			HttpContext.Session.SetString("UserPhone", user.DienThoai);
			HttpContext.Session.SetString("UserAddress", user.DiaChi);
			HttpContext.Session.SetInt32("UserID", user.MaKh);

			return RedirectToAction("Index", "Home");
        }
		[HttpPost]
		public IActionResult Register(string username, string address, string phone, string email, string password, string confirmpassword)
		{
            if(password != confirmpassword)
            {
                ViewBag.Error = "Mật khẩu không khớp!";
                return View();
            }
            else
            {
                var khachHang = new KhachHang();
                khachHang.TenKh = username;
                khachHang.DiaChi = address;
                khachHang.DienThoai = phone;
                khachHang.Email = email;
                khachHang.MatKhau = password;
                _context.KhachHangs.Add(khachHang);

                _context.SaveChanges();
            }
            
            return RedirectToAction("Login", "KhachHangs");
		}


        private bool KhachHangExists(int id)
        {
          return (_context.KhachHangs?.Any(e => e.MaKh == id)).GetValueOrDefault();
        }
    }
}
