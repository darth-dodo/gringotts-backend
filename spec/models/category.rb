require "rails_helper"

RSpec.describe Account, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:expense_logs) }
    it { should have_many(:favourites) }
  end
end
