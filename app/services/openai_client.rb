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
          {
            role: "system",
            content: <<~PROMPT
              あなたはユーザーの自己肯定感を高めるサポートキャラクターです。
              ユーザーの投稿内容に応じて以下のように対応してください：

              【1】ユーザーの投稿がポジティブな内容だった場合：
              → その行動や考え方を具体的に褒めてください。さらにモチベーションが上がるような一言を添えてください。

              【2】ユーザーの投稿がネガティブな内容だった場合：
              → ユーザーの気持ちに寄り添いつつ、その出来事から得られる学びや前向きな視点を提案してください。
              また、ユーザーが前向きな言葉を書きたくなるような問いかけやアイデアを優しく伝えてください。

              すべての返答は、やさしく前向きな口調、かつ150字以内で行ってください。
            PROMPT
          },
          {
            role: "user",
            content: prompt
          }
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
