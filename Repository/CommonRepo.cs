using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;

namespace Repository
{
    public class CommonRepo : ICommonRepo
    {
     
        public DataTable SaveTask(TaskViewModel model, int userId)
        {
            try
            {
                DbManager dbManager = new DbManager();

                List<SqlParameter> parameters = new List<SqlParameter>
                {
                    new SqlParameter("@TaskId", model.TaskId),
                    new SqlParameter("@TaskTitle", model.TaskTitle),
                    new SqlParameter("@TaskDescription", model.TaskDescription),
                    new SqlParameter("@TaskDueDate", model.TaskDueDate),
                    new SqlParameter("@TaskStatus", model.TaskStatus),
                    new SqlParameter("@TaskRemarks", model.TaskRemarks),
                    new SqlParameter("@UserId", userId)
                };
                return   dbManager.ExecuteSP_DataTable("Task_Save", parameters);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        public DataTable GetAllOrSearchTask( string searchText, string status, DateTime? fromDate,DateTime? toDate)
        {
            try
            {
                DbManager db = new DbManager();

                List<SqlParameter> parameters = new List<SqlParameter>
                 {
                     new SqlParameter("@SearchText", (object)searchText ?? DBNull.Value),
                     new SqlParameter("@Status", (object)status ?? DBNull.Value),
                     new SqlParameter("@FromDate", (object)fromDate ?? DBNull.Value),
                     new SqlParameter("@ToDate", (object)toDate ?? DBNull.Value)
                 };

                return db.ExecuteSP_DataTable("Task_GetAllOrSearch", parameters);
            }catch(Exception ex)
            {
                throw ex;
            }
        }


        public DataTable DeleteTask(int id)
        {
            try
            {
                DbManager dbManager = new DbManager();

                List<SqlParameter> parameters = new List<SqlParameter>
                {
                    new SqlParameter("@TaskId", id)
                };
                return dbManager.ExecuteSP_DataTable("Task_Delete", parameters);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

    }
}
