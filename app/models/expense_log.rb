class ExpenseLog < ApplicationRecord
  has_paper_trail

  # imports
  include Frozen
  include FavoritableConcern

  # constants
  module Constants
    IMMUTABLE_FIELDS = [
        :mode,
        :amount,
        :account_id,
        :category_id,
        :user_id
    ].freeze
  end

  enum mode: {
      credit: 0,
      debit: 1
  }

  # concern config
  freeze_fields ExpenseLog::Constants::IMMUTABLE_FIELDS
  acts_as_taggable

  # associations
  belongs_to :user
  belongs_to :account
  belongs_to :category
  has_many :favorites, as: :favoritable

  # https://simonecarletti.com/blog/2009/12/inside-ruby-on-rails-delegate/
  delegate :internal_transfer?, to: :category

  # todo(juneja) confirm this has one relationship
  has_one :internal_transfer_log

  # validations
  before_validation :validate_for_frozen_fields, on: :update
  validates_numericality_of :amount, greater_than_or_equal_to: 0
  validates_presence_of :mode
  validates_presence_of :account
  validates_presence_of :user
  validates_presence_of :category
  # validate :category_belongs_to_relevant_mode
  validate :account_belongs_to_user
  validate :category_belongs_to_user
  validate :balance_available_for_transaction

  # scopes
  scope :for_user, ->(user) { where(user_id: user.id) }

  # callbacks

  def account_belongs_to_user
    unless self.account.user == self.user
      self.errors.add(:base, "Account does not belong to the user!")
    end
  end

  def category_belongs_to_user

    # or something similar to this
    # self.user.categories.include? self.category

    unless self.category.user == self.user
      self.errors.add(:base, "Category does not belong to the user!")
    end
  end

  # todo(Nagekar) this feels very hacky
  def category_belongs_to_relevant_mode
    category_mode = self.category.eligible_mode
    category_mode_mappings = Category::Constants::MODE_MAPPINGS

    potential_log_mappings = category_mode_mappings[category_mode]

    current_mode = self.mode

    unless category_mode_mappings.include? current_mode
      self.errors.add(:base, "Category should be of #{category_mode.to_s.humanize} family across the mode #{current_mode.to_s.humanize}")
    end
  end

  def balance_available_for_transaction
    if self.amount > self.account.current_value and self.debit?
      self.errors.add(:base, "Insufficient balance for the log!")
    end
  end

  # instance methods
end

# == Schema Information
#
# Table name: expense_logs
#
#  id          :bigint           not null, primary key
#  amount      :float            not null
#  mode        :integer          not null
#  note        :text
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
