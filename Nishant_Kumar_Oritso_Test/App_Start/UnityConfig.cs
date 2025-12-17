using Manager;
using Models;
using Repository;
using System;
using System.Web.Mvc;
using Unity;
using Unity.Mvc5;

namespace Nishant_Kumar_Oritso_Test
{
    public static class UnityConfig
    {
        #region Unity Container
        private static Lazy<IUnityContainer> container =
          new Lazy<IUnityContainer>(() =>
          {
              var container = new UnityContainer();
              RegisterTypes(container);
              return container;
          });

        /// <summary>
        /// This is the property UnityMvcActivator is looking for!
        /// </summary>
        public static IUnityContainer Container => container.Value;
        #endregion

        public static void RegisterTypes(IUnityContainer container)
        {
            // REGISTER YOUR REPOSITORY HERE
            // Example:
            // container.RegisterType<ITaskRepository, TaskRepository>();
            container.RegisterType<ICommonRepo, CommonRepo>();
           container.RegisterType<ICommonMan, CommonMan>();
           container.RegisterType<TaskViewModel>();
        }
    }
    // public static class UnityConfig
    // {
    //     public static void RegisterComponents()
    //     {
    //var container = new UnityContainer();

    //         // register all your components with the container here
    //         // it is NOT necessary to register your controllers

    //         // e.g. container.RegisterType<ITestService, TestService>();

    //         DependencyResolver.SetResolver(new UnityDependencyResolver(container));
    //     }
    // }
}