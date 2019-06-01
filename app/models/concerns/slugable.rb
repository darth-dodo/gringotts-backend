module Slugable extend ActiveSupport::Concern

included do
  class_attribute :slugable_attribute

  def generate_slug
    attr_name = self.class.slugable_attribute
    attr_value = self[attr_name]
    self.slug = attr_value.parameterize
  end

end

module ClassMethods
  def source_for_slug(value)
    self.slugable_attribute = value
  end
end
end