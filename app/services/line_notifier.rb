require "net/http"
require "uri"
require "json"

class LineNotifier
  ENDPOINT = "https://api.line.me/v2/bot/message/push"

  def self.push_message(user_line_id, text)
    uri = URI.parse(ENDPOINT)
    header = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{Rails.application.credentials.dig(:line, :channel_token)}"
    }

    body = {
      to: user_line_id,
      messages: [{ type: "text", text: text }]
    }

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = body.to_json
      http.request(request)
    end
  end
end
