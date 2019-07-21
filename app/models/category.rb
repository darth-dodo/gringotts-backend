class Category < ApplicationRecord
  has_paper_trail

  # imports
  include Slugable
  include Frozen
  include FavoritableConcern

  module Constants
    IMMUTABLE_FIELDS = [:eligible_mode,
    :category_type
    ].freeze
    # category_mode: log_mode
    MODE_MAPPINGS = {
        creditable: [:credit],
        debitable: [:debit]
    }
  end

  # concern config
  source_for_slug :name
  freeze_fields Category::Constants::IMMUTABLE_FIELDS
  source_for_favoritable_user_association :user

  enum eligible_mode: {
      creditable: 0,
      debitable: 1
  }

  # todo(juneja) add a standard category type and make this non nullable
  enum category_type: {
      internal_transfer: 0
  }

  # associations
  belongs_to :user
  has_many :expense_logs
  has_many :favorites, as: :favoritable



  # validations
  before_validation :validate_for_frozen_fields, on: :update
  before_validation :generate_slug, if: :name_changed?

  validates_presence_of :name
  validates_presence_of :user
  validates_presence_of :slug
  validates_presence_of :eligible_mode

  validates_uniqueness_of :name, scope: :user_id
  validates_uniqueness_of :slug, scope: :user_id

  # scopes
  scope :for_user, ->(user) { where(user_id: user.id) }
  scope :for_slug, ->(slug) { where(slug: slug) }
  scope :for_type, ->(category_type){ where(category_type: category_type) }
  scope :internal_transfers, ->(){self.for_type("internal_transfer")}

  # instance methods
  # callbacks

end

# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  category_type  :integer
#  eligible_mode  :integer          not null
#  inactivated_at :datetime
#  name           :string           not null, indexed => [user_id]
#  slug           :string           not null
#  user_id        :bigint           not null, indexed, indexed => [name]
#
# Indexes
#
#  index_categories_on_user_id           (user_id)
#  index_categories_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
