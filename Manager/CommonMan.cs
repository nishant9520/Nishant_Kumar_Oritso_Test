using Models;
using Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Manager
{
    public class CommonMan : ICommonMan
    {
        private readonly ICommonRepo _repo;

        public CommonMan(ICommonRepo repo)
        {
            _repo = repo;
        }


        public JsonResult SaveTask(TaskViewModel model, int userId)
        {
            try
            {
                DataTable dt = _repo.SaveTask(model, userId);

                if (dt == null || dt.Rows.Count == 0)
                {
                    return new JsonResult
                    {
                        Data = new
                        {
                            success = false,
                            message = "No response from database"
                        }
                    };
                }

                DataRow row = dt.Rows[0];

                bool isSuccess = Convert.ToBoolean(row["Status"]);
                string message = row["Message"].ToString();


                return new JsonResult
                {
                    Data = new
                    {
                        success = isSuccess,
                        message = message
                    }
                };
            }
            catch (Exception ex)
            {
                return new JsonResult
                {
                    Data = new
                    {
                        success = false,
                        message = ex.Message
                    }
                };
            }
        }



        public List<TaskViewModel> GetAllOrSearchTask( string searchText,string status, DateTime? fromDate, DateTime? toDate)
        {
            DataTable dt = _repo.GetAllOrSearchTask(searchText, status, fromDate, toDate);

            List<TaskViewModel> list = new List<TaskViewModel>();

            foreach (DataRow row in dt.Rows)
            {
                list.Add(new TaskViewModel
                {
                    TaskId = Convert.ToInt32(row["TaskId"]),
                    TaskTitle = row["TaskTitle"].ToString(),
                    TaskDescription = row["TaskDescription"].ToString(),
                    TaskDueDate = Convert.ToDateTime(row["TaskDueDate"]),
                    TaskStatus = row["TaskStatus"].ToString(),
                    TaskRemarks = row["TaskRemarks"].ToString(),
                    CreatedOn = Convert.ToDateTime(row["CreatedOn"])
                });
            }

            return list;
        }


          public JsonResult DeleteTask(int id)
        {
            try
            {
                DataTable dt = _repo.DeleteTask(id);

                if (dt == null || dt.Rows.Count == 0)
                {
                    return new JsonResult
                    {
                        Data = new
                        {
                            success = false,
                            message = "No response from database"
                        }
                    };
                }

                DataRow row = dt.Rows[0];

                bool isSuccess = Convert.ToBoolean(row["Status"]);
                string message = row["Message"].ToString();


                return new JsonResult
                {
                    Data = new
                    {
                        success = isSuccess,
                        message = message
                    }
                };
            }
            catch (Exception ex)
            {
                return new JsonResult
                {
                    Data = new
                    {
                        success = false,
                        message = ex.Message
                    }
                };
            }
        }

        public List<LoginUserDetails> UserLogin(LoginViewModel model)
        {
            DataTable dt = _repo.UserLogin(model);

            List<LoginUserDetails> list = new List<LoginUserDetails>();

            foreach (DataRow row in dt.Rows)
            {
                list.Add(new LoginUserDetails
                {
                    Id = Convert.ToInt32(row["UserId"]),
                    UserName = row["UserName"].ToString(),
                    Message = row["Message"].ToString()
                });
            }

            return list;
        }



    }
}
