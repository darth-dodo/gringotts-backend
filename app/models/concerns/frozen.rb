module Frozen extend ActiveSupport::Concern

    included do
      class_attribute :frozen_fields

      def validate_for_frozen_fields
        frozen_fields = self.class.frozen_fields

        raise Exception.new("Invalid configuration for frozen fields for #{self.class.name.humanize}") unless frozen_fields.is_a? Array
        currently_changed_fields = self.changed.map(&:to_sym)
        mutated_fields = frozen_fields & currently_changed_fields

        if mutated_fields.present?
          mutated_fields.each do |current_mutated_field|
            error_message = "#{current_mutated_field.to_s.humanize} cannot be changed!"
            self.errors.add(:base, error_message)
          end
          false
        end # if
      end
    end

    module ClassMethods
      def freeze_fields(value)
        self.frozen_fields = value
      end
    end

end