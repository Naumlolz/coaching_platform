class UsersCoachesInvitation < ApplicationRecord
  validates :body, :accepted, :user_id, :coach_id, presence: true

  belongs_to :user
  belongs_to :coach
end
