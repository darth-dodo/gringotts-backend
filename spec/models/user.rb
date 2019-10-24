require "rails_helper"

RSpec.describe Account, type: :model do
  describe "Associations" do
    it { should have_many(:categories) }
    it { should have_many(:accounts) }
    it { should have_many(:expense_logs) }
    it { should have_many(:internal_transfer_logs).through(:expense_logs) }
    it { should have_many(:favourites).inverse_of(:user) }
    it { should have_many(:favorite_categories).through(:favorites).source(:favoritable) }
    it { should have_many(:favorite_accounts).through(:favorites).source(:favoritable) }
    it { should have_many(:favorite_expense_logs).through(:favorites).source(:favoritable) }
  end
end
