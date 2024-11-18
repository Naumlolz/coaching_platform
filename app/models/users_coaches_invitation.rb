class UsersCoachesInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :coach
end
