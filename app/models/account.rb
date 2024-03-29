class Account < ApplicationRecord
  has_paper_trail

  attr_accessor :skip_frozen_fields_validation
=begin
discuss with Nagekar the concept of passbook and wallet and wallet abstraction
  attr_accessor :transaction_log
=end

  # imports
  include Slugable
  include Frozen
  include FavoritableConcern

  module Constants
    IMMUTABLE_FIELDS = [:user_id].freeze
  end

  # concern config
  source_for_slug :name
  freeze_fields Account::Constants::IMMUTABLE_FIELDS
  source_for_favoritable_user_association :user

  # associations
  belongs_to :user
  has_many :expense_logs
  has_many :internal_transfer_logs

  has_many :internal_transfer_logs_as_source_account, :class_name => 'InternalTransferLog', :foreign_key => 'source_account_id'

  has_many :internal_transfer_logs_as_destination_account, :class_name => 'InternalTransferLog', :foreign_key => 'destination_account_id'

  has_many :favorites, as: :favoritable

  # validations
  before_validation :validate_for_frozen_fields, on: :update
  before_validation :generate_slug, if: :name_changed?

  validates_presence_of :name
  validates_presence_of :slug
  validates_presence_of :user, message: "should belong to a user!"
  validates_uniqueness_of :name, scope: :user
  # by default numericality does not allow nils
  # https://guides.rubyonrails.org/active_record_validations.html#numericality
  validates_numericality_of :current_value, greater_than_or_equal_to: 0, message: "cannot be negative!"
  before_create :account_should_start_with_zero_value

  # model config

  # scopes
  scope :for_user, ->(user) { where(user_id: user.id) }
  scope :for_slug, ->(slug) { where(slug: slug) }


  # callbacks
  def account_should_start_with_zero_value
    self.current_value = 0
  end

  # instance methods
  # todo(juneja) create an inactivation concern
  def active?
    self.inactivated_at.blank?
  end

end

# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  current_value  :float            default(0.0), not null
#  inactivated_at :datetime
#  name           :string           not null, indexed => [user_id]
#  note           :text
#  slug           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null, indexed => [name], indexed
#
# Indexes
#
#  index_accounts_on_name_and_user_id  (name,user_id) UNIQUE
#  index_accounts_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
