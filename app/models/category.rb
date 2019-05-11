class Category < ApplicationRecord
  include Slugable

  source_for_slug :name

  enum eligible_mode: {
      creditable: 0,
      debitable: 1
  }

  # associations
  belongs_to :user
  has_many :expense_logs

  # validations
  before_validation :generate_slug, if: :name_changed?

  validates_presence_of :name
  validates_presence_of :user
  validates_presence_of :slug
  validates_presence_of :eligible_mode

  # scopes

  # callbacks

  # instance methods

end

