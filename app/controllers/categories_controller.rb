class CategoriesController < ApiController

  before_action :set_category_from_param!, only: [:show, :update, :toggle_favorite]
  include FavoriteHelper

  def index
    categories = Category.for_user(current_user)
    # json_response categories
    # todo(juneja) figure this abstraction out or replace with fast json api
    render json: categories, methods: [:marked_as_favorite], status: :ok
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

  def toggle_favorite
    updated_category = toggle_entity_as_favoritable! @category
    render json: updated_category, methods: [:marked_as_favorite], status: :ok
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
