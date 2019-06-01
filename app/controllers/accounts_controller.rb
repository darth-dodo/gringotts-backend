class AccountsController < ApiController
  before_action :set_account_from_param!, only: [:show, :update]

  def index
    accounts = Account.for_user(current_user)
    json_response accounts
  end

  def create
    account = Account.create!(account_creation_params)
    json_response account, :created
  end

  def show
    json_response @account
  end

  def update
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
