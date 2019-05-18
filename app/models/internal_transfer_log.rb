class InternalTransferLog < ApplicationRecord
  # imports
  include Frozen

  # constants
  module Constants
    IMMUTABLE_FIELDS = [:destination_account,
                        :expense_log,
                        :source_account].freeze
  end

  # concern config
  freeze_fields InternalTransferLog::Constants::IMMUTABLE_FIELDS

  # enums

  # associations
  belongs_to :account, class_name: 'Account', foreign_key: 'source_account_id'
  belongs_to :account, class_name: 'Account', foreign_key: 'destination_account_id'
  belongs_to :expense_log

  # validations
  validates_presence_of :destination_account
  validates_presence_of :source_account
  validates_presence_of :expense_log
  validate :source_and_destination_accounts_should_belong_to_the_same_user, on: :create
  validate :source_and_destination_accounts_should_be_active, on: :create

  # scopes

  # callbacks
  def source_and_destination_accounts_should_belong_to_the_same_user
    unless self.expense_log.user == self.destination_account.user &&  self.expense_log.user == self.source_account.user
      errors.add(:base, "Source and Destination accounts for internal transfer should belong to the the same user!")
    end

    # todo(juneja) explain nagekar about false in validations
    false
  end

  def source_and_destination_accounts_should_be_active
    unless self.source_account.active?
      self.errors.add(:base, "Source account is inactive!")
    end

    unless self.destination_account.active?
      self.errors.add(:base, "Destination account is inactive!")
    end

  end

  # instance methods

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
