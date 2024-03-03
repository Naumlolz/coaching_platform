FactoryBot.define do
  factory :technique do
    name { "Example Technique" }
    description { "This is a sample technique description." }
    association :program
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
