> Source: https://docs.firecrawl.dev/quickstarts/ruby.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Ruby

> Get started with Firecrawl in Ruby. Search, scrape, and interact with web data using the REST API.

## Prerequisites

* Ruby 3.0+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Search the web

Firecrawl works with Ruby through the REST API using `net/http`.

```ruby
require "net/http"
require "json"
require "uri"

api_key = ENV.fetch("FIRECRAWL_API_KEY")

uri = URI("https://api.firecrawl.dev/v2/search")
request = Net::HTTP::Post.new(uri)
request["Authorization"] = "Bearer #{api_key}"
request["Content-Type"] = "application/json"
request.body = { query: "firecrawl web scraping", limit: 5 }.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
results = JSON.parse(response.body)

results["data"]["web"].each do |result|
  puts "#{result['title']} - #{result['url']}"
end
```

## Scrape a page

```ruby
uri = URI("https://api.firecrawl.dev/v2/scrape")
request = Net::HTTP::Post.new(uri)
request["Authorization"] = "Bearer #{api_key}"
request["Content-Type"] = "application/json"
request.body = { url: "https://example.com" }.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
data = JSON.parse(response.body)

puts data.dig("data", "markdown")
```


  ```json
  {
    "success": true,
    "data": {
      "markdown": "# Example Domain\n\nThis domain is for use in illustrative examples...",
      "metadata": {
        "title": "Example Domain",
        "sourceURL": "https://example.com"
      }
    }
  }
  ```


## Interact with a page

Scrape a page, then keep working with it using natural language prompts.

```ruby
uri = URI("https://api.firecrawl.dev/v2/scrape")
request = Net::HTTP::Post.new(uri)
request["Authorization"] = "Bearer #{api_key}"
request["Content-Type"] = "application/json"
request.body = { url: "https://www.amazon.com", formats: ["markdown"] }.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
scrape_id = JSON.parse(response.body).dig("data", "metadata", "scrapeId")

interact_uri = URI("https://api.firecrawl.dev/v2/scrape/#{scrape_id}/interact")
interact_req = Net::HTTP::Post.new(interact_uri)
interact_req["Authorization"] = "Bearer #{api_key}"
interact_req["Content-Type"] = "application/json"
interact_req.body = { prompt: "Search for iPhone 16 Pro Max" }.to_json

interact_resp = Net::HTTP.start(interact_uri.hostname, interact_uri.port, use_ssl: true) { |http| http.request(interact_req) }
puts JSON.parse(interact_resp.body)

# Stop the session
delete_uri = URI("https://api.firecrawl.dev/v2/scrape/#{scrape_id}/interact")
delete_req = Net::HTTP::Delete.new(delete_uri)
delete_req["Authorization"] = "Bearer #{api_key}"
Net::HTTP.start(delete_uri.hostname, delete_uri.port, use_ssl: true) { |http| http.request(delete_req) }
```

## Next steps


    All scrape options including formats, actions, and proxies


    Search the web and get full page content


    Complete REST API documentation


    Click, fill forms, and extract dynamic content


