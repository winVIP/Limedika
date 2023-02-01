using Limedika.DbEntities;
using Limedika.DbEntities.Tables;
using Limedika.Helpers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Runtime.CompilerServices;

namespace Limedika.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ClientController : ControllerBase
    {
        private readonly ClientDbContext clientDbContext;
        private readonly IConfiguration configuration;

        public ClientController(ClientDbContext clientDbContext, IConfiguration configuration)
        {
            this.clientDbContext = clientDbContext;
            this.configuration = configuration;
        }

        [HttpPost]
        public ActionResult ImportClients(List<Models.Client> clients)
        {
            try
            {
                var newClients = clients
                    .DistinctBy(x => new { x.Name, x.Address })
                    .Where(x => !clientDbContext.Client.Any(
                        y => y.Name == x.Name
                        && y.Address == x.Address
                    ));
                clientDbContext.Client.AddRange(newClients.Select(x => new Client()
                {
                    Address = x.Address,
                    Name = x.Name,
                    PostCode = x.PostCode,
                    ClientChangesLog = new List<ClientChangesLog>()
                    {
                        new ClientChangesLog()
                        {
                            Date= DateTime.Now,
                            Action = "New client insertion"
                        }
                    }
                }));

                clientDbContext.SaveChanges();
                return Ok();
            }
            catch(Exception ex)
            {
                return BadRequest();
            }
        }

        [HttpGet]
        public ActionResult GetClients()
        {
            try
            {
                var clients = 
                    clientDbContext.Client
                    .Include(x => x.ClientChangesLog)
                    .ToList();
                return Ok(clients);
            }
            catch(Exception ex)
            {
                return BadRequest();
            }            
        }

        [HttpPatch]
        public async Task<ActionResult> UpdatePostCodes()
        {
            try
            {
                var clients = clientDbContext.Client.ToList().Select(x => x.Address);
                var apiUrl = configuration.GetValue<string>("APIUrls:Posti");
                var apiKey = configuration.GetValue<string>("APIKeys:Posti");
                var newPostCodes = await PostCodeHelper.GetPostCode(clients, apiUrl, apiKey);
                await clientDbContext.Client.Include(x => x.ClientChangesLog).ForEachAsync(x =>
                {
                    string? newPostCode; 
                    if(newPostCodes.TryGetValue(x.Address, out newPostCode))
                    {
                        x.PostCode = newPostCode;
                        x.ClientChangesLog?.Add(new ClientChangesLog()
                        {
                            Date = DateTime.Now,
                            Action = "Post code updated",
                        });
                    }
                    
                });
                clientDbContext.SaveChanges();
                return Ok(newPostCodes);
            }
            catch(Exception ex)
            {
                return BadRequest();
            }
        }
    }
}
