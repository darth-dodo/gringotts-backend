class InternalTransferLog < ApplicationRecord
  belongs_to :account, class_name: 'Account', foreign_key: 'source_account_id'
  belongs_to :account, class_name: 'Account', foreign_key: 'destination_account_id'
  belongs_to :expense_log
end
