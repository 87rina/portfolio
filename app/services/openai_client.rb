require "openai"

class OpenaiClient # OpenAIとの接続クラス
  def initialize
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.openai[:api_key])
  end

  def generate_response(prompt)
    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: prompt }
        ],
        temperature: 0.7
      }
    )

    ai_message = response.dig("choices", 0, "message", "content")

  unless ai_message
    Rails.logger.error("OpenAI response failed or empty: #{response.inspect}")
  end

  ai_message
  end
end
