class Coach < ApplicationRecord
  has_one_attached :avatar

  validates :first_name, :last_name, presence: true
  validates :password, presence: true, confirmation: true
  validates :email, uniqueness: true, presence: true

  has_many :users
  has_many :users_coaches_invitations
  has_many :coaches_programs
  has_many :programs, through: :coaches_programs
  has_many :messages, dependent: :destroy
end
