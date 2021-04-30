class User < ApplicationRecord
  belongs_to :coach
  belongs_to :program
  has_many :users_techniques
  has_many :techniques, :through :users_techniques
  has_many :users_techniques_ratings
  has_many :users_coaches_invitations
end
