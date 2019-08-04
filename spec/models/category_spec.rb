require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:expense_logs) }
    it { should have_many(:favorites) }
  end

  describe "Integrity Validations" do

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:eligible_mode) }


    it "should check for eligible mode enum" do
      should define_enum_for(:eligible_mode).
          with_values(
              creditable: 0,
              debitable: 1
          )
    end

    it "should check for category_type enum" do
      should define_enum_for(:category_type).
          with_values(
              internal_transfer: 0
          )
    end

    it "should validate eligible_mode immutability" do
      salary_category = create(:salary_category)
      salary_category.eligible_mode = "debitable"
      salary_category.save
      expect(salary_category.errors.full_messages.first).to eq("Eligible mode cannot be changed!")
    end

    it "should validate category_type immutability" do
      salary_category = create(:salary_category)
      salary_category.category_type = "internal_transfer"
      salary_category.save
      expect(salary_category.errors.full_messages.first).to eq("Category type cannot be changed!")
    end

    it "should validate user_id immutability" do
      demo_user = create(:demo_user)
      salary_category = create(:salary_category)
      salary_category.user = demo_user
      salary_category.save
      expect(salary_category.errors.full_messages.first).to eq("User cannot be changed!")
    end

  end

end