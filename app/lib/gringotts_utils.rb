module GringottsUtils extend ActiveSupport::Concern
  included do
    def generate_uuid
      SecureRandom.uuid
    end
  end
end
