# == Schema Information
#
# Table name: favorites
#
#  id               :bigint           not null, primary key
#  favoritable_type :string           indexed => [favoritable_id], indexed => [favoritable_id]
#  favoritable_id   :bigint           indexed => [favoritable_type], indexed => [favoritable_type]
#  user_id          :bigint           indexed
#
# Indexes
#
#  index_favorites_on_favoritable_id_and_favoritable_type  (favoritable_id,favoritable_type) UNIQUE
#  index_favorites_on_favoritable_type_and_favoritable_id  (favoritable_type,favoritable_id)
#  index_favorites_on_user_id                              (user_id)
#

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
