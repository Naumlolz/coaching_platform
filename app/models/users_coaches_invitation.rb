class UsersCoachesInvitation < ApplicationRecord
  validates :user_id, :coach_id, presence: true

  belongs_to :user
  belongs_to :coach
end
