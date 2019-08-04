FactoryBot.define do
  factory :user do
    password { "wesdrftgy456u&IAUKnhgfg" }

    trait :admin do
      email { "admin@gringotts.com" }
    end

    trait :demo do
      email { "demo@gringotts.com" }
    end

    factory :admin_user,   traits: [:admin]
    factory :demo_user,   traits: [:demo]

  end
end
