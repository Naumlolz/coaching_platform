class UsersTechniquesRating < ApplicationRecord
  validates :rate, :user_id, :technique_id, presence: true

  belongs_to :user
  belongs_to :technique
end
