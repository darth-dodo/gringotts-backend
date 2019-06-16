class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.register_apis({
  '1.0' => {
    # controller_base_path: '',
    api_file_path: 'public/apidocs',
    base_path: 'http://localhost:3000',
    clean_directory: true
  }
})

Swagger::Docs::Config.base_api_controller = ActionController::API
