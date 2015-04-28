using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace AngularSql
{

    public class Login : IHttpHandler
    {

        public void ProcessRequest(HttpContext Context)
        {
            LoginRequest Request; LoginResponse Response = null;
            try
            {
                if (!LoginRequest.TryParse(Context.Request, out Request)) throw new InvalidCastException("asql:Invalid login request");
                using (SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Database"].ConnectionString))
                {
                    Connection.Open();
                    using (SqlTransaction Transaction = Connection.BeginTransaction(IsolationLevel.ReadUncommitted))
                    {
                        try
                        {
                            using (SqlCommand Command = new SqlCommand())
                            {
                                Command.Connection = Connection;
                                Command.Transaction = Transaction;
                                Command.CommandType = CommandType.StoredProcedure;
                                Command.CommandText = "apiUserLogin";
                                Command.Parameters.AddWithValue("Email", Request.Email);
                                using (SqlDataReader Reader = Command.ExecuteReader(CommandBehavior.SingleRow))
                                {
                                    if (Reader.HasRows)
                                        if (Reader.Read())
                                            if (Security.VerifyPassword(Request.Password, Reader.GetString(0)))
                                                Response = new LoginResponse(Reader.GetInt32(1));
                                }
                            }
                            Transaction.Commit();
                        }
                        catch (SqlException Exception) { 
                            Transaction.Rollback();
                            throw Exception;
                        }
                    }
                    Connection.Close();
                }

            }
            catch (Exception Ex) { Response = new LoginResponse(Logging.Log("Login", Ex.Message)); }
            if (Response == null) Response = new LoginResponse(Logging.Log("Login", "No response."));
            Context.Response.ContentType = "text/plain";
            Context.Response.Write("Hello World");
        }

        public bool IsReusable { get { return false; } }

    }
}