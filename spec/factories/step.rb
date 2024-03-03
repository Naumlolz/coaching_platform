FactoryBot.define do
  factory :step do
    title { "Example Step" }
    body { "This is a sample step body." }
    position { 1 }
    association :technique
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
