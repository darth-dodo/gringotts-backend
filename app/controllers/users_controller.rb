class UsersController < ApiController
  include ApipieHelper
  skip_before_action :authorize_request, only: :create

  def_param_group :create_user do
    param :user, Hash do
      param :name, String, "Name of the user"
      param :email, String, "Email of the User"
    end
  end  

  def_param_group :new_user do
    param :user, Hash do
      param :name, String, "Name of the user"
      param :email, String, "Email of the User"
    end
  end  

  api :POST, "/users", "Create a user"
  param_group :create_user
  returns :new_user, code: 200, desc: "Detailed info about the pet"
  def create
    user = User.create!(user_params)
    auth_token = AuthServices::AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.user_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private
  def user_params
    params.permit(
              :name,
              :email,
              :password,
              :password_confirmation
    )
  end

end
