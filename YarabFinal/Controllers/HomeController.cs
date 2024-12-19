using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using YarabFinal.Models;

namespace YarabFinal.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly GengoContext _context;

        public HomeController(ILogger<HomeController> logger, GengoContext context)
        {
            _logger = logger;
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string email, string password)
        {
            var successParam = new SqlParameter("@success", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };
            var userTypeParam = new SqlParameter("@user_type", System.Data.SqlDbType.NVarChar, 50) { Direction = System.Data.ParameterDirection.Output };
            var usernameParam = new SqlParameter("@username", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

            await _context.Database.ExecuteSqlRawAsync(
                "EXEC loginproc @email, @password, @success OUTPUT, @user_type OUTPUT, @username OUTPUT",
                new SqlParameter("@email", email),
                new SqlParameter("@password", password),
                successParam, userTypeParam, usernameParam
            );

            if ((int)successParam.Value == 1)
            {
                var userType = userTypeParam.Value.ToString();
                var username = (int)usernameParam.Value;

                // Redirect based on user type
                return userType switch
                {
                    "Learner" => RedirectToAction("Details", "Learners", new { id = username }),
                    "Instructor" => RedirectToAction("Details", "Instructors", new { id = username }),
                    "Admin" => RedirectToAction("Details", "Users", new { id = username }),
                    _ => RedirectToAction("Index")
                };
            }

            ModelState.AddModelError("", "Invalid email or password");
            return View("Index");
        }


        // Register Method
        [HttpPost]
        public async Task<IActionResult> Register(string email, string password, string fullName, string userType)
        {
            var usernameParam = new SqlParameter("@username", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };

            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC registerproc @email, @password, @full_name, @user_type, @username OUTPUT",
                    new SqlParameter("@email", email),
                    new SqlParameter("@password", password),
                    new SqlParameter("@full_name", fullName),
                    new SqlParameter("@user_type", userType),
                    usernameParam
                );

                TempData["Message"] = "Registration successful. Please log in.";
                return RedirectToAction("Index");
            }
            catch (SqlException ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View("Index");
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
