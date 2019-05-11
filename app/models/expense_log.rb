class ExpenseLog < ApplicationRecord

  # constants

  # concern config

  # associations
  belongs_to :user
  belongs_to :account
  belongs_to :category

  # todo(juneja) confirm this has one relationship
  has_one :internal_transfer_log

  # validations

  # scopes

  # callbacks

  # instance methods

end

# == Schema Information
#
# Table name: expense_logs
#
#  id          :bigint           not null, primary key
#  amount      :float            not null
#  mode        :integer          not null
#  note        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null, indexed
#  category_id :bigint           not null, indexed
#  user_id     :bigint           not null, indexed
#
# Indexes
#
#  index_expense_logs_on_account_id   (account_id)
#  index_expense_logs_on_category_id  (category_id)
#  index_expense_logs_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
