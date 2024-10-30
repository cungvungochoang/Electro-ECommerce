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
    public class LoaiSpsController : Controller
    {
        private readonly DbGearshopContext _context;

        public LoaiSpsController(DbGearshopContext context)
        {
            _context = context;
        }

        // GET: Admin/LoaiSps
        public async Task<IActionResult> Index()
        {
              return _context.LoaiSps != null ? 
                          View(await _context.LoaiSps.ToListAsync()) :
                          Problem("Entity set 'DbGearshopContext.LoaiSps'  is null.");
        }

        // GET: Admin/LoaiSps/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.LoaiSps == null)
            {
                return NotFound();
            }

            var loaiSp = await _context.LoaiSps
                .FirstOrDefaultAsync(m => m.MaLoaiSp == id);
            if (loaiSp == null)
            {
                return NotFound();
            }

            return View(loaiSp);
        }

        // GET: Admin/LoaiSps/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/LoaiSps/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaLoaiSp,TenLoaiSp")] LoaiSp loaiSp)
        {
            if (ModelState.IsValid)
            {
                _context.Add(loaiSp);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(loaiSp);
        }

        // GET: Admin/LoaiSps/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.LoaiSps == null)
            {
                return NotFound();
            }

            var loaiSp = await _context.LoaiSps.FindAsync(id);
            if (loaiSp == null)
            {
                return NotFound();
            }
            return View(loaiSp);
        }

        // POST: Admin/LoaiSps/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MaLoaiSp,TenLoaiSp")] LoaiSp loaiSp)
        {
            if (id != loaiSp.MaLoaiSp)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(loaiSp);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!LoaiSpExists(loaiSp.MaLoaiSp))
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
            return View(loaiSp);
        }

        // GET: Admin/LoaiSps/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.LoaiSps == null)
            {
                return NotFound();
            }

            var loaiSp = await _context.LoaiSps
                .FirstOrDefaultAsync(m => m.MaLoaiSp == id);
            if (loaiSp == null)
            {
                return NotFound();
            }

            return View(loaiSp);
        }

        // POST: Admin/LoaiSps/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.LoaiSps == null)
            {
                return Problem("Entity set 'DbGearshopContext.LoaiSps'  is null.");
            }
            var loaiSp = await _context.LoaiSps.FindAsync(id);
            if (loaiSp != null)
            {
                _context.LoaiSps.Remove(loaiSp);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool LoaiSpExists(int id)
        {
          return (_context.LoaiSps?.Any(e => e.MaLoaiSp == id)).GetValueOrDefault();
        }
    }
}
