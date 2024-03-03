FactoryBot.define do
  factory :users_coaches_invitation do
    association :user
    association :coach
    accepted { nil }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end