module ExceptionHandler  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
  end

  private

  def record_not_found
    binding.pry
    json_response( { message: Message.not_found }, :not_found)
  end

  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

end