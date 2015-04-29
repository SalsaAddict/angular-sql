using Newtonsoft.Json;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Web;

namespace AngularSql
{

    public class Procedure
    {

        [JsonProperty("Token")]
        public string Token { get; set; }

        [JsonProperty("Name")]
        public string Name { get; set; }

        [JsonProperty("Parameters")]
        public List<Parameter> Parameters { get; set; }

        [JsonProperty("Type")]
        public string Type { get; set; }

        [JsonProperty("UserId")]
        public int UserId { get { try { return Security.UserIdFromToken(this.Token); } catch { return -1; } } }

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