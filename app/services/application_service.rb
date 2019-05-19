# https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
class ApplicationService
  attr_accessor :errors

  def initialize
    @errors = Array.new
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end

  private

  def error(error_message)
    if error_message.is_a? Array
      @errors.concat error_message
    elsif error_message.is_a? String
      @errors << error_message
    end
  end

  def valid?
    @errors.blank?
  end

end