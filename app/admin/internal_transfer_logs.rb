ActiveAdmin.register InternalTransferLog do
  scope_to :current_user
  actions :index, :show

  index do
    column :source_account
    column :destination_account
    column :expense_log
    actions
  end
end
