class ApiController < ActionController::API
  include Response
  include ExceptionHandler
  include GringottsUtils

  before_action :authorize_request
  before_action :set_paper_trail_whodunnit
  before_action :set_raven_context!
  attr_reader :current_user


  private

  def authorize_request
    auth_service = AuthServices::AuthorizeApiRequest.new(request.headers)
    auth_service.call
    @current_user = auth_service.user
  end

  # todo(juneja) check if this sentry code can be moved to a concern
  def set_raven_context!
    # set Raven context irrespective of the user presence for in depth error analysis
    @current_user.blank? ? Raven.user_context(id: nil) : Raven.user_context(id: @current_user.id)
    Raven.extra_context(generate_sentry_params)
  end

  def generate_sentry_params
    params_hash = Hash.new
    params_hash[:params] = params.to_unsafe_h
    params_hash[:url] = request.url
    params_hash[:uuid] = generate_uuid
    params_hash
  end


end
