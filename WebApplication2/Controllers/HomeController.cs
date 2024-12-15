using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using System;
using WebApplication2.Models;

namespace WebApplication2.Controllers
{
    public class HomeController : Controller
    {
        private readonly GengoContext _context;

        public HomeController(GengoContext context)
        {
            _context = context;
        }

        // GET: Home/Index
        public IActionResult Index()
        {
            return View();
        }

        // POST: Home/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string email, string password)
        {
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ViewBag.LoginErrorMessage = "Please enter both email and password.";
                return View("Index");
            }

            // Query the Users table for email and password match
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email && u.Password == password);

            if (user == null)
            {
                ViewBag.LoginErrorMessage = "Invalid email or password.";
                return View("Index");
            }

            // Redirect to details page based on user type
            switch (user.UserType.ToLower())
            {
                case "learner":
                    var learner = await _context.Learners.FirstOrDefaultAsync(l => l.Email == email);
                    if (learner != null)
                    {
                        return RedirectToAction("Details", "Learners", new { id = learner.LearnerId });
                    }
                    break;

                case "instructor":
                    var instructor = await _context.Instructors.FirstOrDefaultAsync(i => i.Email == email);
                    if (instructor != null)
                    {
                        return RedirectToAction("Details", "Instructors", new { id = instructor.InstructorId });
                    }
                    break;

                case "admin":
                    return RedirectToAction("Details", "Users", new { id = user.Username });

                default:
                    ViewBag.LoginErrorMessage = "Unknown user type.";
                    return View("Index");
            }

            ViewBag.LoginErrorMessage = "User details not found.";
            return View("Index");
        }

        // POST: Home/Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register(string email, string password, string userType)
        {
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(userType))
            {
                ViewBag.RegisterErrorMessage = "Please fill out all fields.";
                return View("Index");
            }

            // Check if the user already exists
            if (await _context.Users.AnyAsync(u => u.Email == email))
            {
                ViewBag.RegisterErrorMessage = "An account with this email already exists.";
                return View("Index");
            }

            // Add a new user to the Users table
            var user = new User
            {
                Email = email,
                Password = password,
                UserType = userType,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            // Add additional learner or instructor records if necessary
            switch (userType.ToLower())
            {
                case "learner":
                    var learner = new Learner
                    {
                        Email = email,
                       
                    };
                    _context.Learners.Add(learner);
                    await _context.SaveChangesAsync();
                    return RedirectToAction("Details", "Learners", new { id = learner.LearnerId });

                case "instructor":
                    var instructor = new Instructor
                    {
                        Email = email,
                        
                    };
                    _context.Instructors.Add(instructor);
                    await _context.SaveChangesAsync();
                    return RedirectToAction("Details", "Instructors", new { id = instructor.InstructorId });

                case "admin":
                    return RedirectToAction("Details", "Users", new { id = user.Username });

                default:
                    ViewBag.RegisterErrorMessage = "Unknown user type.";
                    return View("Index");
            }
        }
    }
}
