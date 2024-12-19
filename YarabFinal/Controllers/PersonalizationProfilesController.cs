using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using YarabFinal.Models;

namespace YarabFinal.Controllers
{
    public class PersonalizationProfilesController : Controller
    {
        private readonly GengoContext _context;

        public PersonalizationProfilesController(GengoContext context)
        {
            _context = context;
        }

        // GET: PersonalizationProfiles
        public IActionResult Index(int? learnerId)
        {
            // Fetch all profiles or filter based on learnerId
            IQueryable<PersonalizationProfile> profiles = _context.PersonalizationProfiles;

            if (learnerId.HasValue)
            {
                profiles = profiles.Where(p => p.LearnerId == learnerId.Value);
            }

            return View(profiles.ToList());
        }


        // GET: PersonalizationProfiles/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var personalizationProfile = await _context.PersonalizationProfiles
                .Include(p => p.Learner)
                .FirstOrDefaultAsync(m => m.LearnerId == id);
            if (personalizationProfile == null)
            {
                return NotFound();
            }

            return View(personalizationProfile);
        }

        // GET: PersonalizationProfiles/Create
        public IActionResult Create(int? learnerId)
        {
            var profile = new PersonalizationProfile();

            if (learnerId.HasValue)
            {
                profile.LearnerId = learnerId.Value; // Pre-assign LearnerId to the model
            }

            return View(profile);
        }


        // POST: PersonalizationProfiles/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("LearnerID,ProfileID,PreferedContentType,EmotionalState,PersonalityType")] PersonalizationProfile profile)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Call the stored procedure to create a new Personalization Profile
                    _context.Database.ExecuteSqlRaw(
                        "EXEC createPersonalizationProfile @LearnerID, @ProfileID, @PreferedContentType, @EmotionalState, @PersonalityType",
                        new SqlParameter("@LearnerID", profile.LearnerId),
                        new SqlParameter("@ProfileID", profile.ProfileId),
                        new SqlParameter("@PreferedContentType", profile.PreferedContentType),
                        new SqlParameter("@EmotionalState", profile.EmotionalState),
                        new SqlParameter("@PersonalityType", profile.PersonalityType)
                    );

                    // Redirect back to the Learner's Details page after successful creation
                    return RedirectToAction("Details", "Learners", new { id = profile.LearnerId });
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "Error: " + ex.Message);
                }
            }
            return View(profile);
        }


        // GET: PersonalizationProfiles/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var personalizationProfile = await _context.PersonalizationProfiles.FindAsync(id);
            if (personalizationProfile == null)
            {
                return NotFound();
            }
            ViewData["LearnerId"] = new SelectList(_context.Learners, "LearnerId", "LearnerId", personalizationProfile.LearnerId);
            return View(personalizationProfile);
        }

        // POST: PersonalizationProfiles/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("LearnerId,ProfileId,PreferedContentType,EmotionalState,PersonalityType")] PersonalizationProfile personalizationProfile)
        {
            if (id != personalizationProfile.LearnerId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(personalizationProfile);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!PersonalizationProfileExists(personalizationProfile.LearnerId))
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
            ViewData["LearnerId"] = new SelectList(_context.Learners, "LearnerId", "LearnerId", personalizationProfile.LearnerId);
            return View(personalizationProfile);
        }

        // GET: PersonalizationProfiles/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var personalizationProfile = await _context.PersonalizationProfiles
                .Include(p => p.Learner)
                .FirstOrDefaultAsync(m => m.ProfileId == id); // Ensure correct column match

            if (personalizationProfile == null)
            {
                return NotFound();
            }

            return View(personalizationProfile);
        }


        // POST: PersonalizationProfiles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var personalizationProfile = await _context.PersonalizationProfiles.FindAsync(id);
            if (personalizationProfile != null)
            {
                _context.PersonalizationProfiles.Remove(personalizationProfile);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }


        private bool PersonalizationProfileExists(int id)
        {
            return _context.PersonalizationProfiles.Any(e => e.LearnerId == id);
        }
    }
}
