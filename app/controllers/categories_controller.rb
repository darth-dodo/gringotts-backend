class CategoriesController < ApiController

  before_action :set_category_from_param!, only: [:show, :update]

  respond_to :json

  swagger_controller :categories, 'Categories'

  swagger_api :index do
    summary 'Returns all categories'
    notes 'Notes...'
  end  

  def index
    categories = Category.for_user(current_user)
    json_response categories
  end

  def show
    json_response @category
  end

  def create
    category = Category.create!(category_creation_params)
    json_response category, :created
  end

  def update
    @category.update!(category_update_params)
    json_response @category, :ok
  end

  private
  def category_creation_params
    params.permit(
    :name,
    :eligible_mode,
    :category_type
    ).merge( {user: current_user})
  end

  def category_update_params
    params.permit(
    :name,
    :category_type
    ).merge({ user: current_user })
  end

  def set_category_from_param!
    @category = Category.for_user(current_user).find(params[:id])
  end

end
