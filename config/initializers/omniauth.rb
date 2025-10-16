Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line,
           Rails.application.credentials.dig(:line, :key),
           Rails.application.credentials.dig(:line, :secret),
           scope: "profile openid email",
           redirect_uri: "#{ENV['APP_URL']}/users/auth/line/callback"
end
