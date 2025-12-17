using Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Manager
{
    public class CommonMan : ICommonMan
    {
        private readonly ICommonRepo _repo;

        public CommonMan(ICommonRepo repo)
        {
            _repo = repo;
        }

        public string GetAll()
        {
         return   _repo.GetAll();
            // test
        }
    }
}
