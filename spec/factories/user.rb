FactoryBot.define do
  factory :user do
    first_name { "Ivan" }
    last_name { "Ivanov" }
    email { "test#{rand(100)}@example.com" }
    password { BCrypt::Password.create("example_password") }
    gender { "male" }
    age { rand(100) }
  end
end