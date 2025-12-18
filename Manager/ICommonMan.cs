using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Models;

namespace Manager
{
    public interface ICommonMan
    {
        JsonResult SaveTask(TaskViewModel model, int userId);

        List<TaskViewModel> GetAllOrSearchTask(string searchText, string status, DateTime? fromDate, DateTime? toDate);

        JsonResult DeleteTask(int id);


        List<LoginUserDetails> UserLogin(LoginViewModel model);

    }
}
