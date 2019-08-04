FactoryBot.define do
  factory :account do
    association :user, factory: :admin_user

    trait :salary do
      name { "Salary" }
    end

    trait :cash do
      name { "Cash" }
    end

    trait :savings do
      name { "Savings" }
    end

    factory :salary_account , traits: [:salary]
    factory :cash_account , traits: [:cash]
    factory :savings_account , traits: [:savings]

  end
end