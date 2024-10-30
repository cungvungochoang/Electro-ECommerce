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
    public class PhieuNhapsController : Controller
    {
        private readonly DbGearshopContext _context;

        public PhieuNhapsController(DbGearshopContext context)
        {
            _context = context;
        }

        // GET: Admin/PhieuNhaps
        public async Task<IActionResult> Index()
        {
            var dbGearshopContext = _context.PhieuNhaps.Include(p => p.MaNccNavigation).Include(p => p.MaNvNavigation);
            return View(await dbGearshopContext.ToListAsync());
        }

        // GET: Admin/PhieuNhaps/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.PhieuNhaps == null)
            {
                return NotFound();
            }

            var phieuNhap = await _context.PhieuNhaps
                .Include(p => p.MaNccNavigation)
                .Include(p => p.MaNvNavigation)
                .FirstOrDefaultAsync(m => m.MaPn == id);
            if (phieuNhap == null)
            {
                return NotFound();
            }

            return View(phieuNhap);
        }

        // GET: Admin/PhieuNhaps/Create
        public IActionResult Create()
        {
            ViewData["MaNcc"] = new SelectList(_context.NhaCungCaps, "MaNcc", "MaNcc");
            ViewData["MaNv"] = new SelectList(_context.NhanViens, "MaNv", "MaNv");
            return View();
        }

        // POST: Admin/PhieuNhaps/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaPn,MaNcc,MaNv,NgayNhap,TongTienPn,GhiChu")] PhieuNhap phieuNhap)
        {
            if (ModelState.IsValid)
            {
                _context.Add(phieuNhap);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MaNcc"] = new SelectList(_context.NhaCungCaps, "MaNcc", "MaNcc", phieuNhap.MaNcc);
            ViewData["MaNv"] = new SelectList(_context.NhanViens, "MaNv", "MaNv", phieuNhap.MaNv);
            return View(phieuNhap);
        }

        // GET: Admin/PhieuNhaps/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.PhieuNhaps == null)
            {
                return NotFound();
            }

            var phieuNhap = await _context.PhieuNhaps.FindAsync(id);
            if (phieuNhap == null)
            {
                return NotFound();
            }
            ViewData["MaNcc"] = new SelectList(_context.NhaCungCaps, "MaNcc", "MaNcc", phieuNhap.MaNcc);
            ViewData["MaNv"] = new SelectList(_context.NhanViens, "MaNv", "MaNv", phieuNhap.MaNv);
            return View(phieuNhap);
        }

        // POST: Admin/PhieuNhaps/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MaPn,MaNcc,MaNv,NgayNhap,TongTienPn,GhiChu")] PhieuNhap phieuNhap)
        {
            if (id != phieuNhap.MaPn)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(phieuNhap);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!PhieuNhapExists(phieuNhap.MaPn))
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
            ViewData["MaNcc"] = new SelectList(_context.NhaCungCaps, "MaNcc", "MaNcc", phieuNhap.MaNcc);
            ViewData["MaNv"] = new SelectList(_context.NhanViens, "MaNv", "MaNv", phieuNhap.MaNv);
            return View(phieuNhap);
        }

        // GET: Admin/PhieuNhaps/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.PhieuNhaps == null)
            {
                return NotFound();
            }

            var phieuNhap = await _context.PhieuNhaps
                .Include(p => p.MaNccNavigation)
                .Include(p => p.MaNvNavigation)
                .FirstOrDefaultAsync(m => m.MaPn == id);
            if (phieuNhap == null)
            {
                return NotFound();
            }

            return View(phieuNhap);
        }

        // POST: Admin/PhieuNhaps/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.PhieuNhaps == null)
            {
                return Problem("Entity set 'DbGearshopContext.PhieuNhaps'  is null.");
            }
            var phieuNhap = await _context.PhieuNhaps.FindAsync(id);
            if (phieuNhap != null)
            {
                _context.PhieuNhaps.Remove(phieuNhap);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool PhieuNhapExists(int id)
        {
          return (_context.PhieuNhaps?.Any(e => e.MaPn == id)).GetValueOrDefault();
        }
    }
}
