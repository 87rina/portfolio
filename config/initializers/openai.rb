require "openai"

OpenAI.configure do |config|
  config.access_token =
    Rails.env.production? ? ENV["OPENAI_API_KEY"] : Rails.application.credentials.dig(:openai, :api_key)
  config.log_errors = true # 開発時にエラーを確認できるようにする。本番環境ではfalseにする
end
