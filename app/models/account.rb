class Account < ApplicationRecord

  belongs_to :user
  has_many :expense_logs
  has_many :internal_transfer_logs

end
