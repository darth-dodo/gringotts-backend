class AccountsController < ApiController
  before_action :set_account_from_param!, only: [:show, :update]

  def index
=begin
    url: https://gringotts-backend.herokuapp.com/accounts/
    payload:
    {
      "email": "test@test12.com",
      "password": "apples2"
    }
=end
    accounts = Account.for_user(current_user)
    json_response accounts
  end

  def create
=begin
    POST url: https://gringotts-backend.herokuapp.com/accounts/
    payload:
    {
      "name": "Salary"
    }
=end
    account = Account.create!(account_creation_params)
    json_response account, :created
  end

  def show
=begin
    GET url: https://gringotts-backend.herokuapp.com/accounts/1/
=end
    json_response @account
  end

  def update
=begin
    url: https://gringotts-backend.herokuapp.com/signup
    payload:
    {
      "email": "test@test12.com",
      "password": "apples2"
    }
=end
    @account.update!(account_update_params)
    json_response @account, :ok
  end

  private
  def account_creation_params
    params.permit(
    :name,
    :note
    ).merge({ user: current_user })
  end

  def account_update_params
    # https://stackoverflow.com/a/5150695/10400264
    params.permit(
    :name,
    :note
    )
  end

  def set_account_from_param!
    @account = Account.for_user(current_user).find(params[:id])
  end

end
