class Coach < ApplicationRecord
  has_one_attached :avatar
  
  validates :first_name, :last_name, :email, presence: true
  validates :password, presence: true, confirmation: true

  has_many :users
  has_many :users_coaches_invitations
end
