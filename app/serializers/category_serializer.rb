class CategorySerializer < BaseSerializer
  belongs_to :user

  attributes :id, :category_type,
             :slug, :inactivated_at,
             :user

end