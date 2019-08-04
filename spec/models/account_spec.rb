require "rails_helper"

RSpec.describe Account, type: :model do

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:expense_logs) }
    it { should have_many(:internal_transfer_logs_as_source_account) }
    it { should have_many(:internal_transfer_logs_as_destination_account) }
    it { should have_many(:favorites) }
  end

  describe "Integrity Validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:slug) }
      it { should validate_presence_of(:slug) }
      it { should validate_presence_of(:user).with_message("should belong to a user!") }
      it { should validate_numericality_of(:current_value)
                      .is_greater_than_or_equal_to(0)
                      .with_message("cannot be negative!") }

      it "should validate that account_should_start_with_zero_value" do
        admin_user = create(:admin_user)
        new_account = Account.new
        new_account.user = admin_user
        new_account.name = "Test"
        new_account.current_value = 10000
        new_account.save
        new_account.reload
        expect(new_account.current_value).to eq(0)
      end
  end

  describe "Immutable entities" do
    it "should confirm immutable entities" do
      user_2 = create(:demo_user)
      salary_account_obj = create(:salary_account)
      salary_account_obj.user = user_2
      expect(salary_account_obj.save).to be(false)
      expect(salary_account_obj.errors.full_messages.size).to eq(1)
      expect(salary_account_obj.errors.full_messages.first).to eq("User cannot be changed!")
    end
  end

end
