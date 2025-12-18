using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;

namespace Repository
{
    public interface ICommonRepo
    {
        DataTable SaveTask(TaskViewModel model, int userId);
        DataTable UserLogin(LoginViewModel model);

        DataTable GetAllOrSearchTask(string searchText, string status, DateTime? fromDate, DateTime? toDate);

        DataTable DeleteTask(int id);
    }
}
