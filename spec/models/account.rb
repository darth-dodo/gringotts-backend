require "rails_helper"

RSpec.describe Account, type: :model do

  describe "Validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:slug) }
      it { should validate_presence_of(:slug) }
      it { should validate_presence_of(:user).with_message("should belong to a user!") }
    end

  context "with 2 accounts" do
    it "create two accounts" do

      admin_user = create(:admin_user)
      demo_user = create(:demo_user)

      account_1 = {
          "name": "Acct 1",
          "user_id": admin_user.id,
          "current_value": 2000
      }

      account_2 = account_1.dup
      account_2["name"] = "Acct 2"

      Account.create! account_1
      Account.create! account_2

      all_accounts = Account.all
      expect(all_accounts.size).to eq(2)

      account_names = all_accounts.map(&:name)

      expect(account_names).to eq(["Acct 1", "Acct 2"])

    end
  end
end
