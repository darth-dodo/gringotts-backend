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
  end

  describe "Immutable entities" do
  end

end
