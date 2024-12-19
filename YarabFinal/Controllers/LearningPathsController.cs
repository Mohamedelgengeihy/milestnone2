using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using YarabFinal.Models;

namespace YarabFinal.Controllers
{
    public class LearningPathsController : Controller
    {
        private readonly GengoContext _context;

        public LearningPathsController(GengoContext context)
        {
            _context = context;
        }

        // GET: LearningPaths
        public async Task<IActionResult> Index()
        {
            var gengoContext = _context.LearningPaths.Include(l => l.PersonalizationProfile);
            return View(await gengoContext.ToListAsync());
        }

        // GET: LearningPaths/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learningPath = await _context.LearningPaths
                .Include(l => l.PersonalizationProfile)
                .FirstOrDefaultAsync(m => m.PathId == id);
            if (learningPath == null)
            {
                return NotFound();
            }

            return View(learningPath);
        }

        // GET: LearningPaths/Create
        public IActionResult Create(int LearnerId = 0, int ProfileId = 0, string CustomContent = "", string AdaptiveRules = "")
        {
            ViewData["LearnerId"] = new SelectList(_context.PersonalizationProfiles, "LearnerId", "LearnerId", LearnerId);

            var learningPath = new LearningPath
            {
                LearnerId = LearnerId,
                ProfileId = ProfileId,
                CustomContent = CustomContent,
                AdaptiveRules = AdaptiveRules
            };

            return View(learningPath);
        }

        // POST: LearningPaths/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PathId,LearnerId,ProfileId,CompletionStatus,CustomContent,AdaptiveRules")] LearningPath learningPath)
        {
            if (ModelState.IsValid)
            {
                _context.Add(learningPath);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["LearnerId"] = new SelectList(_context.PersonalizationProfiles, "LearnerId", "LearnerId", learningPath.LearnerId);
            return View(learningPath);
        }

        // GET: LearningPaths/ByLearner/5
        public async Task<IActionResult> ByLearner(int learnerId)
        {
            // Retrieve learning paths specific to the given learnerId
            var learnerPaths = await _context.LearningPaths
                .Where(lp => lp.LearnerId == learnerId)
                .Include(lp => lp.PersonalizationProfile)
                .ToListAsync();

            ViewData["LearnerId"] = learnerId; // Pass the learner ID to the view
            return View("Index", learnerPaths); // Use the existing "Index" view to display filtered paths
        }


        // GET: LearningPaths/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learningPath = await _context.LearningPaths.FindAsync(id);
            if (learningPath == null)
            {
                return NotFound();
            }
            ViewData["LearnerId"] = new SelectList(_context.PersonalizationProfiles, "LearnerId", "LearnerId", learningPath.LearnerId);
            return View(learningPath);
        }

        // POST: LearningPaths/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("PathId,LearnerId,ProfileId,CompletionStatus,CustomContent,AdaptiveRules")] LearningPath learningPath)
        {
            if (id != learningPath.PathId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(learningPath);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!LearningPathExists(learningPath.PathId))
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
            ViewData["LearnerId"] = new SelectList(_context.PersonalizationProfiles, "LearnerId", "LearnerId", learningPath.LearnerId);
            return View(learningPath);
        }

        // GET: LearningPaths/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var learningPath = await _context.LearningPaths
                .Include(l => l.PersonalizationProfile)
                .FirstOrDefaultAsync(m => m.PathId == id);
            if (learningPath == null)
            {
                return NotFound();
            }

            return View(learningPath);
        }

        // POST: LearningPaths/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var learningPath = await _context.LearningPaths.FindAsync(id);
            if (learningPath != null)
            {
                _context.LearningPaths.Remove(learningPath);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        // New Method: View Learning Paths for a Specific Learner
        public async Task<IActionResult> ViewLearnerPaths(int learnerId)
        {
            var learnerPaths = await _context.LearningPaths
                .Where(lp => lp.LearnerId == learnerId)
                .Include(lp => lp.PersonalizationProfile)
                .ToListAsync();

            ViewData["LearnerId"] = learnerId;
            return View("LearnerPaths", learnerPaths);
        }

        private bool LearningPathExists(int id)
        {
            return _context.LearningPaths.Any(e => e.PathId == id);
        }
    }
}
