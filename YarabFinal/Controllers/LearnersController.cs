using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using YarabFinal.Models;

namespace YarabFinal.Controllers
{
    public class LearnersController : Controller
    {
        private readonly GengoContext _context;

        public LearnersController(GengoContext context)
        {
            _context = context;
        }

        // GET: Learners
        public async Task<IActionResult> Index()
        {
            return View(await _context.Learners.ToListAsync());
        }

        // GET: Learners/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var learner = await _context.Learners
                .FirstOrDefaultAsync(m => m.LearnerId == id);
            if (learner == null)
            {
                return NotFound();
            }
            return View(learner);
        }

        // GET: Learners/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Learners/Create
      [HttpPost]
[ValidateAntiForgeryToken]
public async Task<IActionResult> Create([Bind("FirstName,LastName,Gender,BirthDate,Country,Email,CulturalBackground")] Learner learner)
{
    if (ModelState.IsValid)
    {
        // Generate the next LearnerId dynamically
        learner.LearnerId = _context.Learners.Any() ? _context.Learners.Max(l => l.LearnerId) + 1 : 1;

        _context.Add(learner);
        await _context.SaveChangesAsync();
        return RedirectToAction(nameof(Index));
    }
    return View(learner);
}


        // GET: Learners/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learner = await _context.Learners.FindAsync(id);
            if (learner == null)
            {
                return NotFound();
            }
            return View(learner);
        }

        // POST: Learners/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind("LearnerId,FirstName,LastName,Gender,BirthDate,Country,Email,CulturalBackground")] Learner learner)
        {
            if (id != learner.LearnerId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(learner);
                    _context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!_context.Learners.Any(e => e.LearnerId == learner.LearnerId))
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
            return View(learner);
        }

        // GET: Learners/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learner = await _context.Learners
                .FirstOrDefaultAsync(m => m.LearnerId == id);
            if (learner == null)
            {
                return NotFound();
            }

            return View(learner);
        }

        // POST: Learners/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Delete(int id)
        {
            var learner = _context.Learners.Find(id);

            if (learner == null)
            {
                return NotFound();
            }

            _context.Learners.Remove(learner);
            _context.SaveChanges();

            return RedirectToAction(nameof(Index));
        }
    }
}
