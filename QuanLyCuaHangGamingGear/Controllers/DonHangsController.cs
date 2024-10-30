using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using QuanLyCuaHangGamingGear.Helper;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Controllers
{
    public class DonHangsController : Controller
    {
        private readonly DbGearshopContext _context;
		//private readonly IMomoService _momoService;

		public DonHangsController(DbGearshopContext context)
        {
            _context = context;
		}
		//public DonHangsController(DbGearshopContext context, IMomoService momoService)
		//{
		//	_context = context;
		//	_momoService = momoService;
		//}

		// GET: DonHangs
		//public async Task<IActionResult> Index()
		//{
		//    var dbGearshopContext = _context.DonHangs.Include(d => d.MaKhNavigation).Include(d => d.MaSpNavigation);
		//    return View(await dbGearshopContext.ToListAsync());
		//}
		//[HttpPost]
		//public async Task<IActionResult> CreatePaymentUrl(GioHang model)
		//{
		//	var response = await _momoService.CreatePaymentAsync(model);
		//	return Redirect(response.PayUrl);
		//}

		//[HttpGet]
		//public IActionResult PaymentCallBack()
		//{
		//	var response = _momoService.PaymentExecuteAsync(HttpContext.Request.Query);
		//	return View(response);
		//}
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
        public IActionResult CreateOrder()
        {
            List<GioHang> cart = GioHangs;
            var userID = HttpContext.Session.GetInt32("UserID");
            var latestDonHang = _context.DonHangs.OrderByDescending(d => d.MaDh).FirstOrDefault();
			string currentDate = DateTime.Now.ToString("yyyyMMdd");

			// Kiểm tra xem có đơn hàng nào trong cơ sở dữ liệu chưa
			var lastTransaction = _context.DonHangs
				.OrderByDescending(o => o.MaGiaoDich)
				.FirstOrDefault();

			int nextCounter;

			if (lastTransaction != null)
			{
				// Lấy dãy số tự tăng từ mã giao dịch cuối cùng
				nextCounter = int.Parse(lastTransaction.MaGiaoDich.Substring(8)) + 1;
			}
			else
			{
				// Nếu không có đơn hàng nào, bắt đầu từ 1001
				nextCounter = 1001;
			}

			string transactionCode = currentDate + nextCounter.ToString("D4");
			foreach (var item in cart)
            {
                var donHang = new DonHang();
				donHang.MaGiaoDich = transactionCode;
				donHang.MaSp = item.MaSP;
                donHang.SoLuongSp = item.SoLuong;
                donHang.GiaSp = item.DonGia;
                donHang.ThanhTien = item.ThanhTien;
                donHang.MaKh = userID;
				donHang.TenNvpt = "Admin";
				_context.DonHangs.Add(donHang);

				var product = _context.SanPhams.Find(item.MaSP);
				if (product != null)
				{
					product.SoLuong -= item.SoLuong;
				}
				_context.SaveChanges();	
			}
			HttpContext.Session.Remove("GioHang");
			return RedirectToAction("OrderSuccess", "DonHangs");
        }
        public IActionResult Index()
		{
			int? userID = HttpContext.Session.GetInt32("UserID");
			var orders = _context.DonHangs.Where(u => u.MaKh == userID).Include(s => s.MaSpNavigation).Include(s => s.MaKhNavigation).ToList();
            return View(orders);
		}
        public IActionResult Order()
		{
			return View();
		}
		public IActionResult OrderSuccess()
		{
			return View();
		}

		// GET: DonHangs/Details/5
		public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.DonHangs == null)
            {
                return NotFound();
            }

            var donHang = await _context.DonHangs
                .Include(d => d.MaKhNavigation)
                .Include(d => d.MaSpNavigation)
                .FirstOrDefaultAsync(m => m.MaDh == id);
            if (donHang == null)
            {
                return NotFound();
            }

            return View(donHang);
        }

        // GET: DonHangs/Create
        public IActionResult Create()
        {
            ViewData["MaKh"] = new SelectList(_context.KhachHangs, "MaKh", "MaKh");
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp");
            return View();
        }

        // POST: DonHangs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaDh,MaGiaoDich,MaSp,SoLuongSp,GiaSp,ThanhTien,MaKh,TenNvpt,GhiChu")] DonHang donHang)
        {
            if (ModelState.IsValid)
            {
                _context.Add(donHang);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MaKh"] = new SelectList(_context.KhachHangs, "MaKh", "MaKh", donHang.MaKh);
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp", donHang.MaSp);
            return View(donHang);
        }

        // GET: DonHangs/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.DonHangs == null)
            {
                return NotFound();
            }

            var donHang = await _context.DonHangs.FindAsync(id);
            if (donHang == null)
            {
                return NotFound();
            }
            ViewData["MaKh"] = new SelectList(_context.KhachHangs, "MaKh", "MaKh", donHang.MaKh);
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp", donHang.MaSp);
            return View(donHang);
        }

        // POST: DonHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MaDh,MaGiaoDich,MaSp,SoLuongSp,GiaSp,ThanhTien,MaKh,TenNvpt,GhiChu")] DonHang donHang)
        {
            if (id != donHang.MaDh)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(donHang);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!DonHangExists(donHang.MaDh))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["MaKh"] = new SelectList(_context.KhachHangs, "MaKh", "MaKh", donHang.MaKh);
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp", donHang.MaSp);
            return View(donHang);
        }

        // GET: DonHangs/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.DonHangs == null)
            {
                return NotFound();
            }

            var donHang = await _context.DonHangs
                .Include(d => d.MaKhNavigation)
                .Include(d => d.MaSpNavigation)
                .FirstOrDefaultAsync(m => m.MaDh == id);
            if (donHang == null)
            {
                return NotFound();
            }

            return View(donHang);
        }

        // POST: DonHangs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.DonHangs == null)
            {
                return Problem("Entity set 'DbGearshopContext.DonHangs'  is null.");
            }
            var donHang = await _context.DonHangs.FindAsync(id);
            if (donHang != null)
            {
                _context.DonHangs.Remove(donHang);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool DonHangExists(int id)
        {
          return (_context.DonHangs?.Any(e => e.MaDh == id)).GetValueOrDefault();
        }
    }
}
