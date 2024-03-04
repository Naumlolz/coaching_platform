FactoryBot.define do
  factory :users_technique do
    association :user
    association :technique
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
    technique_status { "pending" }  # Замените на значение по умолчанию, если отличается

    # Можете добавить другие атрибуты, если необходимо
  end
end
