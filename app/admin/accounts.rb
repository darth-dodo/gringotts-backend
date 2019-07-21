ActiveAdmin.register Account do
  actions :index, :show
  scope_to :current_user

  index do
    column :name
    column :user
    column :current_value
    column :note
    column :created_at
    actions
  end

end
