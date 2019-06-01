class AccountsController < ApiController
  def index
    accounts = Account.for_user(current_user)
    json_response accounts
  end

  def create
    account = Account.create!(account_creation_params)
    response = { message: Message.account_created, account: account }
    json_response(response, :created)
  end

  private
  def account_creation_params
    params.permit(
    :name,
    :note
    ).merge({ user: current_user })
  end

end
