require "rails_helper"

RSpec.describe InternalTransferLog, type: :model do
  describe "Associations" do
    it { should belong_to(:source_account).class_name('Account') }
    it { should belong_to(:destination_account).class_name('Account') }
    it { should belong_to(:expense_log) }
  end
end
