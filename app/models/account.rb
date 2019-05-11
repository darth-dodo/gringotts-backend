class Account < ApplicationRecord

  belongs_to :user
  has_many :expense_logs
  has_many :internal_transfer_logs

end

# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  current_value  :float            not null
#  inactivated_at :datetime
#  name           :string           not null
#  note           :text
#  slug           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null, indexed
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
