FactoryBot.define do
  factory :category do
    association :user, factory: :admin_user

    trait :commute do
      name { "Commute" }
    end

    trait :food do
      name { "Food" }
    end

    trait :recreation do
      name { "Recreation" }
    end

    trait :cash_transfer do
      name { "Cash Transfer" }
    end

    trait :debitable do
      eligible_mode { "debitable" }
    end

    trait :creditable do
      eligible_mode { "creditable" }
    end

    trait :internal_transfer do
      category_type { "internal_transfer" }
    end

    trait :salary do
      name { "Salary" }
    end

    trait :gift do
      name { "Gift" }
    end

    factory :salary_category, traits: [:salary, :creditable]
    factory :gift_category, traits: [:salary, :creditable]

    factory :food_category , traits: [:food, :debitable]
    factory :recreation_category, traits: [:recreation, :debitable]
    factory :cash_transfer_category, traits: [:cash_transfer, :debitable, :internal_transfer]

  end
end

