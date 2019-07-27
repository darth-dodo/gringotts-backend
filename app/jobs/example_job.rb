class ExampleJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    User.all.map(&:email).each do |current_email|
      puts "Current email id is: #{current_email}"
    end
  end
end
