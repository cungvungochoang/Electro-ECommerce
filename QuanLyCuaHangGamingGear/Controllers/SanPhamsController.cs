using System;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using QuanLyCuaHangGamingGear.Models;
using QuanLyCuaHangGamingGear.Models.ViewModels;

namespace QuanLyCuaHangGamingGear.Controllers
{
    public class SanPhamsController : Controller
    {
        private readonly DbGearshopContext _context;
		private int pageSize = 9;

		public SanPhamsController(DbGearshopContext context)
        {
            _context = context;
        }

		// GET: SanPhams
		public IActionResult Index(int productPage = 1)
		{
			return View(new ProductListVM
			{
				SanPhams = _context.SanPhams.Skip((productPage - 1) * pageSize).Take(pageSize),
				PagingInfo = new PagingInfo
				{
					ItemsPerPage = pageSize,
					CurrentPage = productPage,
					TotalItems = _context.SanPhams.Count()
				}
			});
		}

		[HttpPost]
		public async Task<IActionResult> Index(int cateid, string keyword, int productPage = 1)
		{
			return View("Index",
			new ProductListVM
			{
				SanPhams = _context.SanPhams
				.Where(s => s.TenSp.Contains(keyword) && s.MaLoaiSp == cateid || s.TenSp.Contains(keyword) || s.MaLoaiSp == cateid)
				.Skip((productPage - 1) * pageSize)
				.Take(pageSize),
				PagingInfo = new PagingInfo
				{
					ItemsPerPage = pageSize,
					CurrentPage = productPage,
					TotalItems = _context.SanPhams.Count()
				}
			});
		}
		// GET: SanPhams/Details/5
		public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.SanPhams == null)
            {
                return NotFound();
            }

            var sanPham = await _context.SanPhams
                .Include(s => s.MaHangSxNavigation)
                .Include(s => s.MaLoaiSpNavigation)
                .FirstOrDefaultAsync(m => m.MaSp == id);
            if (sanPham == null)
            {
                return NotFound();
            }
            ViewBag.SanPham = sanPham;
            return View();
        }
        //[Authorize(Roles = "Admin")]
        // GET: SanPhams/Create
        public IActionResult Create()
        {
            ViewData["MaHangSx"] = new SelectList(_context.HangSxes, "MaHangSx", "TenHangSx");
            ViewData["MaLoaiSp"] = new SelectList(_context.LoaiSps, "MaLoaiSp", "TenLoaiSp");
            return View();
        }

        // POST: SanPhams/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        //[Authorize(Roles = "Admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaSp,TenSp,MaLoaiSp,MaHangSx,HinhAnh,GiaSp,SoLuong,MoTa")] SanPham sanPham)
        {
            if (ModelState.IsValid)
            {
                _context.Add(sanPham);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MaHangSx"] = new SelectList(_context.HangSxes, "MaHangSx", "TenHangSx", sanPham.MaHangSx);
            ViewData["MaLoaiSp"] = new SelectList(_context.LoaiSps, "MaLoaiSp", "TenLoaiSp", sanPham.MaLoaiSp);
            return View(sanPham);
        }

        // GET: SanPhams/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.SanPhams == null)
            {
                return NotFound();
            }

            var sanPham = await _context.SanPhams.FindAsync(id);
            if (sanPham == null)
            {
                return NotFound();
            }
            ViewData["MaHangSx"] = new SelectList(_context.HangSxes, "MaHangSx", "MaHangSx", sanPham.MaHangSx);
            ViewData["MaLoaiSp"] = new SelectList(_context.LoaiSps, "MaLoaiSp", "MaLoaiSp", sanPham.MaLoaiSp);
            return View(sanPham);
        }

        // POST: SanPhams/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MaSp,TenSp,MaLoaiSp,MaHangSx,HinhAnh,GiaSp,SoLuong,MoTa")] SanPham sanPham)
        {
            if (id != sanPham.MaSp)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(sanPham);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SanPhamExists(sanPham.MaSp))
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
            ViewData["MaHangSx"] = new SelectList(_context.HangSxes, "MaHangSx", "MaHangSx", sanPham.MaHangSx);
            ViewData["MaLoaiSp"] = new SelectList(_context.LoaiSps, "MaLoaiSp", "MaLoaiSp", sanPham.MaLoaiSp);
            return View(sanPham);
        }

        // GET: SanPhams/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.SanPhams == null)
            {
                return NotFound();
            }

            var sanPham = await _context.SanPhams
                .Include(s => s.MaHangSxNavigation)
                .Include(s => s.MaLoaiSpNavigation)
                .FirstOrDefaultAsync(m => m.MaSp == id);
            if (sanPham == null)
            {
                return NotFound();
            }

            return View(sanPham);
        }

        // POST: SanPhams/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.SanPhams == null)
            {
                return Problem("Entity set 'DbGearshopContext.SanPhams'  is null.");
            }
            var sanPham = await _context.SanPhams.FindAsync(id);
            if (sanPham != null)
            {
                _context.SanPhams.Remove(sanPham);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool SanPhamExists(int id)
        {
          return (_context.SanPhams?.Any(e => e.MaSp == id)).GetValueOrDefault();
        }
    }
}
