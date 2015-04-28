using System.Web;

namespace AngularSql
{

    public class Encrypt : IHttpHandler
    {

        public void ProcessRequest(HttpContext Context)
        {
            string Password = Context.Request.QueryString[0];
            string Encrypted = Security.EncryptPassword(Password);
            bool Match = Security.VerifyPassword(Password, Encrypted);
            Context.Response.ContentType = "text/plain";
            Context.Response.Write(string.Format("{0}\r\n{1}", Encrypted, Match));
        }

        public bool IsReusable { get { return false; } }

    }

}