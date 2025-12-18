using Manager;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
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
            if (Session["UserName"] == null)
                return RedirectToAction("Login", "Auth");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult SaveTask(TaskViewModel model)
        {
            try
            {

                return _man.SaveTask(model, Convert.ToInt32(Session["UserId"].ToString()));
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                });
            }
        }


        [HttpGet]
        public PartialViewResult LoadTaskList( string searchText, string status,DateTime? fromDate, DateTime? toDate)
        {
            searchText = searchText == "" ? null : searchText;
            status = status == "" ? null : status;
            var data = _man.GetAllOrSearchTask(searchText, status, fromDate, toDate);
            return PartialView("_TaskTable", data);
        }

        [HttpPost]
        public JsonResult DeleteTask(int id)
        {
            try
            {
                return _man.DeleteTask(id);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                });
            }
        }
    }
}