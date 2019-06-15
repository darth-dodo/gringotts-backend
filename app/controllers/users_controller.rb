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
    render_json serializer, user
  end

  def index
    # json_response UserSerializer.new(current_user).as_hash[:data]
    render_json serializer, current_user
  end

  private

  def serializer
    UserSerializer
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
