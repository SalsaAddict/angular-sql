namespace AngularSql
{

    public class JsonWebTokenPayload
    {

        public int UserId { get; set; }
        
        public JsonWebTokenPayload() { }
        
        public JsonWebTokenPayload(int UserId) { this.UserId = UserId; }

    }

}