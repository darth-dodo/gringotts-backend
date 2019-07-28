# require 'sidekiq'
#
# if Rails.env.development?
#   Sidekiq.configure_server do |config|
#     config.redis = { url: 'redis://localhost:6379' }
#   end
# end
#
# if Rails.env.production?
#   Sidekiq.configure_client do |config|
#     config.redis = { url: ENV['REDIS_URL'], size: 2 }
#   end
#
#   Sidekiq.configure_server do |config|
#     config.redis = { url: ENV['REDIS_URL'], size: 20 }
#   end
# end
