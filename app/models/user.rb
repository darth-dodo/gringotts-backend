class User < ApplicationRecord
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

  # validations
  before_validation :validate_for_frozen_fields, on: :update

  # scopes

  # instance methods

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
