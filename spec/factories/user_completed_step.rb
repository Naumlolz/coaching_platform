FactoryBot.define do
  factory :user_completed_step do
    association :user
    association :step
    association :technique
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
