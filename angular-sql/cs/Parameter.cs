using Newtonsoft.Json;

namespace AngularSql
{

    public class Parameter
    {

        [JsonProperty("Name")]
        public string Name { get; set; }

        [JsonProperty("Value")]
        public object Value { get; set; }

        [JsonProperty("XML")]
        public bool XML { get; set; }

    }

}