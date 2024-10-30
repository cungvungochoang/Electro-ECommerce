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
    public class HangSxesController : Controller
    {
        private readonly DbGearshopContext _context;

        public HangSxesController(DbGearshopContext context)
        {
            _context = context;
        }

        // GET: Admin/HangSxes
        public async Task<IActionResult> Index()
        {
              return _context.HangSxes != null ? 
                          View(await _context.HangSxes.ToListAsync()) :
                          Problem("Entity set 'DbGearshopContext.HangSxes'  is null.");
        }

        // GET: Admin/HangSxes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.HangSxes == null)
            {
                return NotFound();
            }

            var hangSx = await _context.HangSxes
                .FirstOrDefaultAsync(m => m.MaHangSx == id);
            if (hangSx == null)
            {
                return NotFound();
            }

            return View(hangSx);
        }

        // GET: Admin/HangSxes/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/HangSxes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MaHangSx,TenHangSx")] HangSx hangSx)
        {
            if (ModelState.IsValid)
            {
                _context.Add(hangSx);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(hangSx);
        }

        // GET: Admin/HangSxes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.HangSxes == null)
            {
                return NotFound();
            }

            var hangSx = await _context.HangSxes.FindAsync(id);
            if (hangSx == null)
            {
                return NotFound();
            }
            return View(hangSx);
        }

        // POST: Admin/HangSxes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MaHangSx,TenHangSx")] HangSx hangSx)
        {
            if (id != hangSx.MaHangSx)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(hangSx);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!HangSxExists(hangSx.MaHangSx))
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
            return View(hangSx);
        }

        // GET: Admin/HangSxes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.HangSxes == null)
            {
                return NotFound();
            }

            var hangSx = await _context.HangSxes
                .FirstOrDefaultAsync(m => m.MaHangSx == id);
            if (hangSx == null)
            {
                return NotFound();
            }

            return View(hangSx);
        }

        // POST: Admin/HangSxes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.HangSxes == null)
            {
                return Problem("Entity set 'DbGearshopContext.HangSxes'  is null.");
            }
            var hangSx = await _context.HangSxes.FindAsync(id);
            if (hangSx != null)
            {
                _context.HangSxes.Remove(hangSx);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool HangSxExists(int id)
        {
          return (_context.HangSxes?.Any(e => e.MaHangSx == id)).GetValueOrDefault();
        }
    }
}
