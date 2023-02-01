using System.ComponentModel.DataAnnotations;

namespace Limedika.DbEntities.Tables
{
    public class ClientChangesLog
    {
        public int Id { get; set; }
        public string Action { get; set; }
        public DateTime Date { get; set; }
    }
}
