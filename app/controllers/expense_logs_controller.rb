class ExpenseLogsController < ApiController
  before_action :set_expense_log_from_param!, only: [:show, :update]

  def index
    # expense_logs = ExpenseLog.for_user(current_user) or ->
    expense_logs = current_user.expense_logs
    json_response expense_logs
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
