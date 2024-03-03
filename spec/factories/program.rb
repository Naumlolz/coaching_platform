FactoryBot.define do
  factory :program do
    name { "Example Program" }
    description { "This is a sample program description." }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
