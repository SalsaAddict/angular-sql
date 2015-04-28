using Newtonsoft.Json;
using System.Web;
using System.Text;
using System.IO;

namespace AngularSql
{
    
    public class LoginRequest
    {
        
        [JsonProperty("Email")]
        public string Email { get; set; }

        [JsonProperty("Password")]
        public string Password { get; set; }

        public static bool TryParse(HttpRequest Request, out LoginRequest Result)
        {
            Result = null;
            try
            {
                using (StreamReader Reader = new StreamReader(Request.InputStream, Encoding.UTF8))
                {
                    Result = JsonConvert.DeserializeObject<LoginRequest>(Reader.ReadToEnd());
                    return true;
                }
            }
            catch { return false; }
        }

    }

}