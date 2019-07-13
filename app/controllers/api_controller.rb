class ApiController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  before_action :set_paper_trail_whodunnit
  attr_reader :current_user


  private
  def authorize_request
    auth_service = AuthServices::AuthorizeApiRequest.new(request.headers)
    auth_service.call
    @current_user = auth_service.user
  end

end
