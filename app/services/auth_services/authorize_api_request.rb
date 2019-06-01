module AuthServices
  class AuthorizeApiRequest < ApplicationService
    attr_reader :headers, :user

    def initialize(headers = {})
      super()
      @headers = headers
      @user = nil
    end

    def call
      {
          user: extract_user
      }
    end

    private
    def extract_user
      # check if user is present in the db and memoize user object
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    rescue ActiverRecord::RecordNotFound => e
      raise ExceptionHandler::InvalidToken "#{Message.invalid_token} #{e.message}"
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      end
      raise ExceptionHandler::MissingToken, Message.missing_token
    end

  end
end
