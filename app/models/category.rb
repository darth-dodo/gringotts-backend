class Category < ApplicationRecord

  # imports
  include Slugable
  include Frozen

  # concern config
  source_for_slug :name
  freeze_fields [:eligible_mode]

  enum eligible_mode: {
      creditable: 0,
      debitable: 1
  }

  # associations
  belongs_to :user
  has_many :expense_logs

  # validations
  before_validation :validate_for_frozen_fields, on: :update
  before_validation :generate_slug, if: :name_changed?

  validates_presence_of :name
  validates_presence_of :user
  validates_presence_of :slug
  validates_presence_of :eligible_mode

  # scopes

  # instance methods

  # callbacks

end

# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  eligible_mode  :integer          not null
#  inactivated_at :datetime
#  name           :string           not null
#  slug           :string           not null
#  user_id        :bigint           not null, indexed
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
