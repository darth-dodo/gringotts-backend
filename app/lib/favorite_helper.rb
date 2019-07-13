module FavoriteHelper  extend ActiveSupport::Concern
  included do
    def toggle_entity_as_favoritable!(entity)
=begin
  - Takes in an entity which can be marked as favorite
  - Marks it as favorite if not marked already or unmarks it if marked already
  - Bangable as this can raise an error
=end
      if entity.marked_as_favorite?
        entity.unmark_as_favorite!
      else
        entity.mark_as_favorite!
      end
      entity.reload
    end

  end

end