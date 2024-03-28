FactoryBot.define do
  factory :message do
    association :user
    association :coach
    body { 'Message body' }
    sent_by_coach { false }

    trait :sent_by_coach do
      sent_by_coach { true }
    end
  end
end