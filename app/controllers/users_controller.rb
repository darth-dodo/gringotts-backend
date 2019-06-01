class UsersController < ApiController
  skip_before_action :authorize_request, only: :create


  def create
=begin
    url: https://gringotts-backend.herokuapp.com/signup
    payload:
    {
      "email": "test@test12.com",
      "password": "apples2"
    }
=end
    user = User.create!(user_params)
    auth_token = AuthServices::AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.user_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def user_params
    params.permit(
              :name,
              :email,
              :password,
              :password_confirmation
    )
  end

end
