class ExpenseLogSerializer < BaseSerializer
  attributes :id, :amount, :mode, :note, :created_at, :updated_at,
             :account
  attribute :user
  attribute :category

  # belongs_to :user
  # belongs_to :account
  # belongs_to :category
end