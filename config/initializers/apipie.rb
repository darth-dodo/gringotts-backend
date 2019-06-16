Apipie.configure do |config|
  config.app_name                = "GringottsBackend"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"

  config.default_locale          = 'en'
  config.languages               = ['en']
end
