class InternalTransferLogsController < ApiController

  def index
    internal_transfer_logs = InternalTransferLog.for_user(current_user)
    json_response internal_transfer_logs
  end

  def show
    internal_transfer_log = InternalTransferLog.for_user(current_user).find(params[:id])
    json_response internal_transfer_log
  end

end
