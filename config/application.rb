require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GringottsBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # https://github.com/cyu/rack-cors
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :options]
      end
    end

    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    config.filter_parameters << :password

    config.active_job.queue_adapter = :sidekiq



    # todo(juneja) generate new keys once moved to yaml based config
    Raven.configure do |config|
      config.dsn = 'https://7d062d31b8364229ab7fb79a2615baff:2612a39996f9417aae62173ff511ff7c@sentry.io/1514939'
      config.excluded_exceptions += ['ActionController::RoutingError', 'ActiveRecord::RecordNotFound']
      config.environments = %w[ production ]
    end


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
