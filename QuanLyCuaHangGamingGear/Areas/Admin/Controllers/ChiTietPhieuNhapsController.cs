using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using QuanLyCuaHangGamingGear.Models;

namespace QuanLyCuaHangGamingGear.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class ChiTietPhieuNhapsController : Controller
    {
        private readonly DbGearshopContext _context;

        public ChiTietPhieuNhapsController(DbGearshopContext context)
        {
            _context = context;
        }

        // GET: Admin/ChiTietPhieuNhaps
        public async Task<IActionResult> Index()
        {
            var dbGearshopContext = _context.ChiTietPhieuNhaps.Include(c => c.MaPnNavigation).Include(c => c.MaSpNavigation);
            return View(await dbGearshopContext.ToListAsync());
        }

        // GET: Admin/ChiTietPhieuNhaps/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.ChiTietPhieuNhaps == null)
            {
                return NotFound();
            }

            var chiTietPhieuNhap = await _context.ChiTietPhieuNhaps
                .Include(c => c.MaPnNavigation)
                .Include(c => c.MaSpNavigation)
                .FirstOrDefaultAsync(m => m.MaPn == id);
            if (chiTietPhieuNhap == null)
            {
                return NotFound();
            }

            return View(chiTietPhieuNhap);
        }
        public IActionResult GetDetails(int maPN)
        {
            var details = _context.ChiTietPhieuNhaps.Where(n => n.MaPn == maPN);

            return PartialView("_DetailsPartial", details);
        }

        // GET: Admin/ChiTietPhieuNhaps/Create
        public IActionResult Create()
        {
            ViewData["MaPn"] = new SelectList(_context.PhieuNhaps, "MaPn", "MaPn");
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp");
            return View();
        }

        // POST: Admin/ChiTietPhieuNhaps/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaPn,MaSp,SoLuongSp,GiaNhapSp,TongTienNhapSp,GhiChu")] ChiTietPhieuNhap chiTietPhieuNhap)
        {
            if (ModelState.IsValid)
            {
                _context.Add(chiTietPhieuNhap);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MaPn"] = new SelectList(_context.PhieuNhaps, "MaPn", "MaPn", chiTietPhieuNhap.MaPn);
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp", chiTietPhieuNhap.MaSp);
            return View(chiTietPhieuNhap);
        }

        // GET: Admin/ChiTietPhieuNhaps/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.ChiTietPhieuNhaps == null)
            {
                return NotFound();
            }

            var chiTietPhieuNhap = await _context.ChiTietPhieuNhaps.FindAsync(id);
            if (chiTietPhieuNhap == null)
            {
                return NotFound();
            }
            ViewData["MaPn"] = new SelectList(_context.PhieuNhaps, "MaPn", "MaPn", chiTietPhieuNhap.MaPn);
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp", chiTietPhieuNhap.MaSp);
            return View(chiTietPhieuNhap);
        }

        // POST: Admin/ChiTietPhieuNhaps/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MaPn,MaSp,SoLuongSp,GiaNhapSp,TongTienNhapSp,GhiChu")] ChiTietPhieuNhap chiTietPhieuNhap)
        {
            if (id != chiTietPhieuNhap.MaPn)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(chiTietPhieuNhap);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ChiTietPhieuNhapExists(chiTietPhieuNhap.MaPn))
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
            ViewData["MaPn"] = new SelectList(_context.PhieuNhaps, "MaPn", "MaPn", chiTietPhieuNhap.MaPn);
            ViewData["MaSp"] = new SelectList(_context.SanPhams, "MaSp", "MaSp", chiTietPhieuNhap.MaSp);
            return View(chiTietPhieuNhap);
        }

        // GET: Admin/ChiTietPhieuNhaps/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.ChiTietPhieuNhaps == null)
            {
                return NotFound();
            }

            var chiTietPhieuNhap = await _context.ChiTietPhieuNhaps
                .Include(c => c.MaPnNavigation)
                .Include(c => c.MaSpNavigation)
                .FirstOrDefaultAsync(m => m.MaPn == id);
            if (chiTietPhieuNhap == null)
            {
                return NotFound();
            }

            return View(chiTietPhieuNhap);
        }

        // POST: Admin/ChiTietPhieuNhaps/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.ChiTietPhieuNhaps == null)
            {
                return Problem("Entity set 'DbGearshopContext.ChiTietPhieuNhaps'  is null.");
            }
            var chiTietPhieuNhap = await _context.ChiTietPhieuNhaps.FindAsync(id);
            if (chiTietPhieuNhap != null)
            {
                _context.ChiTietPhieuNhaps.Remove(chiTietPhieuNhap);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ChiTietPhieuNhapExists(int id)
        {
          return (_context.ChiTietPhieuNhaps?.Any(e => e.MaPn == id)).GetValueOrDefault();
        }
    }
}
