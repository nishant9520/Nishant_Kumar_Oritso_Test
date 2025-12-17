using System.Web;
using System.Web.Mvc;

namespace Nishant_Kumar_Oritso_Test
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
