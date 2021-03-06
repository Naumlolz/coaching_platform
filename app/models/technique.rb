class Technique < ApplicationRecord
  validates :name, :description, :program_id, presence: true

  belongs_to :program
  has_many :users_techniques
  has_many :users, through: :users_techniques
  has_many :users_techniques_ratings
  has_many :steps, dependent: :destroy
  has_many :user_completed_steps
end
