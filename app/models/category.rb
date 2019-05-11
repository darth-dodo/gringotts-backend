class Category < ApplicationRecord
  belongs_to :user
  has_many :expense_logs
end

