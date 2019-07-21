ActiveAdmin.register Category do
  actions :index, :show
  scope_to :current_user

  index do
    column :name
    column :user
    column :category_type
    actions
  end
end
