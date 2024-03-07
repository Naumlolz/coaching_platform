FactoryBot.define do
  factory :users_coaches_invitation do
    association :user, :without_coach
    association :coach
    accepted { nil }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
