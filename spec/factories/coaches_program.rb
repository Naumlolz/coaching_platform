FactoryBot.define do
  factory :coaches_program do
    association :coach
    association :program
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
