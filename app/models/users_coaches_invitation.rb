# class which represents users_coaches_invitation
class UsersCoachesInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :coach
end
