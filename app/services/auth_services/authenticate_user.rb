module AuthServices
  class AuthenticateUser < ApplicationService
    attr_reader :email, :password
    def initialize(email, password)
      super()
      @email = email
      @password = password
    end

    def call
      user.jwt_token
    end

    private
    def user
      user = User.find_by(email: email)
      return user if user && user.valid_password?(password)
      raise ExceptionHandler::AuthenticationError, Message.invalid_credentials
    end

  end
end
