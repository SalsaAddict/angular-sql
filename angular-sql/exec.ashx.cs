using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace AngularSql
{

    public class Exec : IHttpHandler
    {

        public void ProcessRequest(HttpContext Context)
        {
            Procedure Procedure;
            if (Procedure.TryParse(Context, out Procedure))
            {
                Context.Response.ContentType = "text/json";
                Context.Response.Write(JsonConvert.SerializeObject(Procedure));
            }
            else
            {
                Context.Response.ContentType = "text/plain";
                Context.Response.Write("Hello World");
            }
        }

        public bool IsReusable { get { return false; } }

    }

}