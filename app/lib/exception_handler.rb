module ExceptionHandler extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  class GringottsValidationError < StandardError
    attr_reader :log_level, :message
    def initialize(message = nil, status_code = nil, log_level = nil)
      @message = message || Message.default_error_message
      @log_level = log_level
    end
  end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::GringottsValidationError, with: :four_zero_zero
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken, with: :unauthorized_request
  end

  private

  def alert_sentry(e)
    # todo(juneja) move the sentry log level to env
    log_level = e.log_level.present? ? e.log_level : "error"
    Raven.capture_exception(e, level: log_level)
  end

  def record_not_found(e)
    json_response( { message: Message.not_found }, :not_found)
  end

  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def four_zero_zero(e)
    json_response({ message: e.message }, :bad_request)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

end
