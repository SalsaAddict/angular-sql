using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace AngularSql
{

    public static class Logging
    {

        public static readonly string UnexpectedError = "An unexpected error occurred.";
        public static readonly string LoggingError = "Unable to log error message.";

        public static string FriendlyMessage(string Message)
        {
            if (Message.StartsWith("asql:"))
                return Message.Substring(5);
            else
                return UnexpectedError;
        }

        public static string Log(string Sender, string Message, int UserId = -1)
        {
            string FriendlyMessage = Logging.FriendlyMessage(Message);
            try
            {
                using (SqlConnection Connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["Database"].ConnectionString))
                {
                    using (SqlCommand Command = new SqlCommand("apiLog", Connection))
                    {
                        Command.CommandType = CommandType.StoredProcedure;
                        Command.Parameters.AddWithValue("Sender", (string.IsNullOrWhiteSpace(Sender)) ? "Unknown" : Sender);
                        Command.Parameters.AddWithValue("Message", Message);
                        Command.Parameters.AddWithValue("Friendly", FriendlyMessage);
                        Command.Parameters.AddWithValue("UserId", UserId);
                        Command.ExecuteNonQuery();
                    }
                }
            }
            catch { FriendlyMessage = LoggingError; }
            return FriendlyMessage;
        }

    }

}