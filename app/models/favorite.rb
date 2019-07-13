class Favorite < ApplicationRecord
  belongs_to :favoritable, polymorphic: true
  belongs_to :user, inverse_of: :favorites

  validates :user_id, uniqueness: {
      scope: [:favoritable_id, :favoritable_type],
      message: 'can only favorite an item once'
  }

  scope :categories, -> { where(favoritable_type: 'Category') }
  scope :accounts, -> { where(favoritable_type: 'Account') }
  scope :expense_logs, -> { where(favoritable_type: 'ExpenseLog') }

  scope :for_user, -> (user) { where(user_id: user.id) }

end