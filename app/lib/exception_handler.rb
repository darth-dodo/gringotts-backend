module ExceptionHandler  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  class GringottsValidationError < StandardError
    def initialize(message = nil, status_code = nil)
      @message = message
    end

    def message
      @message.present? ? @message : "Something went wrong!"
    end

    def status_code_handler
      :bad_request
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