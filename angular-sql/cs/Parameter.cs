using Newtonsoft.Json;

namespace AngularSql
{

    public class UiParameter
    {

        [JsonProperty("Name")]
        public string Name { get; set; }

        private const string UiTypeDefault = "value";
        private string _Type = UiTypeDefault;

        [JsonProperty("Type")]
        public string Type
        {
            get { return _Type; }
            set
            {
                value = (string.IsNullOrWhiteSpace(value)) ? string.Empty : value.Trim().ToLower();
                switch (value)
                {
                    case "route":
                    case "scope": _Type = value; break;
                    default: _Type = UiTypeDefault; break;
                }
            }
        }

        [JsonProperty("Value")]
        public object Value { get; set; }

        [JsonProperty("XML")]
        public bool XML { get; set; }

        public UiParameter()
        {
            this._Type = UiTypeDefault;
            this.XML = false;
        }

    }

}