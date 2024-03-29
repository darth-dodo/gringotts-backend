class User < ApplicationRecord
  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  include Frozen

  # constants
  module Constants
    IMMUTABLE_FIELDS = [:email]
  end

  # concern config
  freeze_fields User::Constants::IMMUTABLE_FIELDS

  # associations
  has_many :categories
  has_many :accounts
  has_many :expense_logs
  has_many :internal_transfer_logs, through: :expense_logs

  # favorites and through relations
  has_many :favorites, inverse_of: :user
  has_many :favorite_categories, through: :favorites, source: :favoritable, source_type: "Category"
  has_many :favorite_accounts, through: :favorites, source: :favoritable, source_type: "Account"
  has_many :favorite_expense_logs, through: :favorites, source: :favoritable, source_type: "ExpenseLog"


  # validations
  before_validation :validate_for_frozen_fields, on: :update

  # scopes

  # instance methods
  def jwt_token
    JsonWebToken.encode(user_id: self.id)
  end

  # callbacks

end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
