ActiveAdmin.register Favorite do
  scope_to :current_user
  actions :index, :show
end
