using System.Text.Json.Serialization;

namespace Limedika.Models
{
    public class PostiGetResult
    {
        [JsonPropertyName("status")]
        public string status { get; set; }
        public bool success { get; set; }
        public string message { get; set; }
        public int message_code { get; set; }
        public int total { get; set; }
        public List<PostiGetResultData> data { get; set; }
    }
}
