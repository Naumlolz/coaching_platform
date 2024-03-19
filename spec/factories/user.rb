FactoryBot.define do
  factory :user do
    association :coach

    first_name { 'Ivan' }
    last_name { 'Ivanov' }
    email { "test#{rand(100)}@example.com" }
    password { BCrypt::Password.create('example_password') }
    gender { 'male' }
    age { rand(5..99) }
    coach_id { coach.id }

    trait :without_coach do
      coach_id { nil }
    end
  end
end
