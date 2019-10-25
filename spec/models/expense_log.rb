require "rails_helper"

RSpec.describe ExpenseLog, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:account) }
    it { should belong_to(:category) }
    it { should have_many(:favorites) }
    it { should have_one(:internal_transfer_log) }
  end
end
