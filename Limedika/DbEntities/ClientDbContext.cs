using Limedika.DbEntities.Tables;
using Microsoft.EntityFrameworkCore;

namespace Limedika.DbEntities
{
    public class ClientDbContext : DbContext
    {
        public ClientDbContext(DbContextOptions<ClientDbContext> options) : base(options) { }

        public DbSet<Client> Client { get; set; }
        public DbSet<ClientChangesLog> ClientChangesLog { get; set; }
    }
}
