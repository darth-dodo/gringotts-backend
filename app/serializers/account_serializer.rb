class AccountSerializer < BaseSerializer
  belongs_to :user

  attributes :id, :current_value, :name, :note,
             :slug, :inactivated_at,
             :created_at, :updated_at
  attribute :user

end