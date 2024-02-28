FactoryBot.define do
  factory :coach do
    first_name { 'Petr' }
    last_name { 'Petrov' }
    description { "professional #{['football', 'basketball'].sample} coach"}
    age { rand(100) }
    gender { ['male', 'female'].sample }
    email { "test_coach#{rand(100)}@example.com" }
    password { BCrypt::Password.create("example_password") }
    education { 'School' }
    experience { 'Arsenal FC' }
    certificate { 'Coach licence' }
  end
end