namespace Limedika.DbEntities.Tables
{
    public class Client
    {
        
        public int? Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string? PostCode { get; set; }
        public List<ClientChangesLog>? ClientChangesLog { get; set; }
    }
}
