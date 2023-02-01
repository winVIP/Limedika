using Limedika.Models;
using Microsoft.AspNetCore.WebUtilities;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Net;

namespace Limedika.Helpers
{
    public class PostCodeHelper
    {
        public static async Task<Dictionary<string, string>> GetPostCode(
            IEnumerable<string> addressList, 
            string apiUrl, 
            string apiKey)
        {
            var results = new Dictionary<string, string>();
            using(var client = new HttpClient())
            {
                var uri = apiUrl;
                foreach (var address in addressList)
                {
                    uri = QueryHelpers.AddQueryString(uri, "term", address);
                    uri = QueryHelpers.AddQueryString(uri, "key", apiKey);

                    var response = await client.GetAsync(uri);
                    var postiGetResult = await response.Content.ReadFromJsonAsync<PostiGetResult>();
                    results.Add(address, postiGetResult.data.First().post_code);
                }
            }
            return results;
        }
    }
}
