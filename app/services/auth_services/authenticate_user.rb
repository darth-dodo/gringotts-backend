module AuthServices
  class AuthenticateUser < ApplicationService
    attr_reader :email, :password
    def initialize(email, password)
      super()
      @email = email
      @password = password
    end

    def call
      JsonWebToken.encode(user_id: user.id) if user
    end

    private
    def user
      user = User.find_by(email: email)
      return user if user && user.valid_password?(password)
      raise ExceptionHandler::AuthenticationError, Message.invalid_credentials
    end

  end
end
