class Coach < ApplicationRecord
  has_many :users
  has_many :users_coaches_invitations
end
