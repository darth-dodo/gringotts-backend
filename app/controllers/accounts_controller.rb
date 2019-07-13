class AccountsController < ApiController
  before_action :set_account_from_param!, only: [:show, :update, :toggle_favorite]

  include FavoriteHelper

  def index
    accounts = Account.for_user(current_user)

    # todo(juneja) figure this abstraction out or replace with fast json api
    render json: accounts, methods: [:marked_as_favorite], status: :ok

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

  def toggle_favorite
    updated_account = toggle_entity_as_favoritable! @account
    render json: updated_account, methods: [:marked_as_favorite], status: :ok
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
