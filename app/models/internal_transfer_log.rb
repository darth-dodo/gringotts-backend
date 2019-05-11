class InternalTransferLog < ApplicationRecord
  belongs_to :account, class_name: 'Account', foreign_key: 'source_account_id'
  belongs_to :account, class_name: 'Account', foreign_key: 'destination_account_id'
  belongs_to :expense_log
end

# == Schema Information
#
# Table name: internal_transfer_logs
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  destination_account_id :bigint           not null, indexed
#  expense_log_id         :bigint           not null, indexed
#  source_account_id      :bigint           not null, indexed
#
# Indexes
#
#  index_internal_transfer_logs_on_destination_account_id  (destination_account_id)
#  index_internal_transfer_logs_on_expense_log_id          (expense_log_id)
#  index_internal_transfer_logs_on_source_account_id       (source_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (destination_account_id => accounts.id)
#  fk_rails_...  (expense_log_id => expense_logs.id)
#  fk_rails_...  (source_account_id => accounts.id)
#
