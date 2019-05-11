class ExpenseLog < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category

  # todo(juneja) confirm this has one relationship
  has_one :internal_transfer_log
end
