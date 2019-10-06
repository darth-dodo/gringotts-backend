require "rails_helper"

RSpec.describe Account, type: :model do

  describe "Validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:slug) }
      it { should validate_presence_of(:slug) }
      it { should validate_presence_of(:user).with_message("should belong to a user!") }

      it "should validate on account_should_start_with_zero_value" do
        admin_user = create(:admin_user)
        admin_account_creation_params = {
            "name": "Acct 1",
            "user_id": admin_user.id,
            "current_value": 2000
        }


        admin_account = Account.create! admin_account_creation_params

        expect(admin_account.current_value).to eq(0)

      end
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:expense_logs) }
    it { should have_many(:internal_transfer_logs_as_source_account) }
    it { should have_many(:favorites) }
  end

  # context "with two accounts" do
  #   it "create two accounts" do
  #
  #     admin_user = create(:admin_user)
  #     demo_user = create(:demo_user)
  #
  #     account_1 = {
  #         "name": "Acct 1",
  #         "user_id": admin_user.id,
  #         "current_value": 2000
  #     }
  #
  #     account_2 = account_1.dup
  #     account_2["name"] = "Acct 2"
  #
  #     Account.create! account_1
  #     Account.create! account_2
  #
  #     all_accounts = Account.all
  #     expect(all_accounts.size).to eq(2)
  #
  #     account_names = all_accounts.map(&:name)
  #
  #     expect(account_names).to eq(["Acct 1", "Acct 2"])
  #   end
  #
  # end


  context "for Frozen Concern" do

    it "checks for immutable user id" do
      admin_user = create(:admin_user)
      admin_account_creation_params = {
          "name": "Acct 1",
          "user_id": admin_user.id,
          "current_value": 2000
      }


      admin_account = Account.create! admin_account_creation_params

      demo_user = create(:demo_user)
      admin_account.user_id = demo_user.id
      admin_account.save

      expect(admin_account.errors.size).to eq(1)
      expect(admin_account.errors.full_messages.first). to eq("User cannot be changed!")
    end

  end

  context "for Slugable Concern" do
    it "should check the name is changed the slug is changed" do
      admin_user = create(:admin_user)
      admin_account_creation_params = {
          "name": "Acct 1",
          "user_id": admin_user.id,
          "current_value": 2000
      }


      admin_account = Account.create! admin_account_creation_params

      new_name = "Changed Name"
      auto_generated_new_slug = "changed-name"
      admin_account.name = "Changed Name"
      admin_account.save

      expect(admin_account.slug).to eq(auto_generated_new_slug)

    end

  end

end
