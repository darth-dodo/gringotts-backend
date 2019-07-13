class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def verbose_errors
    self.errors.present? ? self.errors.full_messages : []
  end

  def verbose_errors_str
    self.verbose_errors.present? ? self.verbose_errors.join(", ") : ""
  end

end
