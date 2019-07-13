module FavoritableConcern extend ActiveSupport::Concern
  included do
    attr_accessor :marked_as_favorite

    class_attribute :user_association

    def mark_as_favorite!
      # todo(juneja) figure out how to pass this assocation to the concern || using the RequestStore
      user_entity = self.class.user_association

      # todo(juneja) currently the user relation is hardcoded for the where clause and likewise, figure out a workaround
      new_favoritable_entity = Favorite.new(user: self.user, favoritable: self)
      new_favoritable_entity.save!
    end

    def unmark_as_favorite!
      return unless marked_as_favorite?
      favorite_record = get_favorite!
      favorite_record.destroy!
    end

    def marked_as_favorite?
      favorite_record = get_favorite!
      favorite_record.present?
    end

    def get_favorite!
      # todo(juneja) currently the user relation is hardcoded for the where clause and likewise, figure out a workaround
      Favorite.joins(:user).where(favoritable: self).first
    end

    def marked_as_favorite
      marked_as_favorite?
    end

  end

  module ClassMethods
    def source_for_favoritable_user_association(value)
      self.user_association = value
    end
  end

end
