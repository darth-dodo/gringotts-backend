class ExpenseLogsController < ApiController
  before_action :set_expense_log_from_param!, only: [:show, :update, :toggle_favorite]
  include FavoriteHelper

  def index
    # expense_logs = ExpenseLog.for_user(current_user) or ->
    expense_logs = current_user.expense_logs
    # json_response expense_logs
    # todo(juneja) abstract render as json out OR move to fast_jsonapi
    render json: expense_logs, methods: [:marked_as_favorite], status: :ok
  end

  def show
    json_response @expense_log
  end

  def create
    expense_log_service = ExpenseLogServices::CreateExpenseLog.new(expense_log_creation_params)
    expense_log_service.call!
    json_response expense_log_service.new_expense_log
  end

  def update
    @expense_log.update!(expense_log_update_params)
    json_response @expense_log
  end

  def toggle_favorite
    updated_expense_log = toggle_entity_as_favoritable! @expense_log
    render json: updated_expense_log, methods: [:marked_as_favorite], status: :ok
  end


  private
  def set_expense_log_from_param!
    @expense_log = ExpenseLog.for_user(current_user).find(params[:id])
  end

  def expense_log_creation_params
    params.permit(
    :account_id,
    :category_id,
    :amount,
    :mode,
    :note,
    :destination_account_id
    ).merge( {user_id: current_user.id })
  end

  def expense_log_update_params
    params.permit(:note)
  end

end
