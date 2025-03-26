FactoryBot.define do
  factory :users_techniques_rating do
    association :user
    association :technique
    rate { 'like' }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
