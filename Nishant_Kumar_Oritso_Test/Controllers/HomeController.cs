using Manager;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nishant_Kumar_Oritso_Test.Controllers
{
    public class HomeController : Controller
    {

        private readonly ICommonMan _man;   

        public HomeController(ICommonMan man)
        {
            _man = man;
        }

        public ActionResult Index()
        {

        var d=     _man.GetAll();
            return View();
        }
        public ActionResult GetTaskList()
        {
            // Use your Manager to get the list
            var list = _man.GetAll();
            return PartialView("_TaskList", list);
        }
        //public ActionResult About()
        //{
        //    ViewBag.Message = "Your application description page.";

        //    return View();
        //}

        //public ActionResult Contact()
        //{
        //    ViewBag.Message = "Your contact page.";

        //    return View();
        //}
    }
}