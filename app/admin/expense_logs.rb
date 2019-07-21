ActiveAdmin.register ExpenseLog do
  actions :index, :show
  scope_to :current_user
  permit_params :amount, :mode, :note, :account, :category, :user

  index do
    column :user
    column :category
    column :account
    column :amount
    column :mode
    column :note
    actions
  end

end
