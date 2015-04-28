using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace AngularSql
{

    public class LoginResponse
    {

        [JsonProperty("Validated")]
        public bool Validated { get; private set; }

        [JsonProperty("Token")]
        public string Token { get; private set; }

        [JsonProperty("Reset")]
        public bool Reset { get; private set; }

        [JsonProperty("Error")]
        public string Error { get; private set; }

        public LoginResponse(int UserId, bool Reset = false)
        {
            this.Validated = true;
            this.Token = Security.TokenFromUserId(UserId);
            this.Reset = Reset;
            this.Error = string.Empty;
        }

        public LoginResponse(string Error)
        {
            this.Validated = false;
            this.Token = string.Empty;
            this.Reset = false;
            this.Error = Error;
        }

    }

}