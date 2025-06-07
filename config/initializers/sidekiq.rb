redis_url = ENV["REDIS_URL"] || "redis://redis:6379/0"
# Redis から Job を取り出し Job の実行を担う(server)
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end
# Job を Redis に格納する処理を担う(client)
Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
