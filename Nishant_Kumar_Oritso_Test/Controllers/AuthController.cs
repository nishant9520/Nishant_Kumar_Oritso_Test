using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Manager;
using Models;

namespace Nishant_Kumar_Oritso_Test.Controllers
{
    public class AuthController : Controller
    {
        private readonly ICommonMan _man;

        public AuthController(ICommonMan man)
        {
            _man = man;
        }

        public ActionResult Login()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Login(LoginViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var result = _man.UserLogin(model);

         
            if (result == null || result.Count == 0)
            {
                ViewBag.Error = "Invalid Email or Password";
                return View(model);
            }

            var user = result.FirstOrDefault();

           
            if (user.Id > 0)
            {
                Session["UserId"] = user.Id;
                Session["UserName"] = user.UserName;

                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Error = user.Message;
                return View(model);
            }
        }


        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }
    }
}