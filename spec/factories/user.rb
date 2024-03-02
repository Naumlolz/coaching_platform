FactoryBot.define do
  factory :user do
    association :coach

    first_name { "Ivan" }
    last_name { "Ivanov" }
    email { "test#{rand(100)}@example.com" }
    password { BCrypt::Password.create("example_password") }
    gender { "male" }
    age { rand(100) }
    coach_id { coach.id }
  end
end