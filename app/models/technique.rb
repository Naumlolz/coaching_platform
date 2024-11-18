class Technique < ApplicationRecord
  validates :name, :description, presence: true

  belongs_to :program
  has_many :users_techniques, dependent: :destroy
  has_many :users, through: :users_techniques
  has_many :users_techniques_ratings, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :user_completed_steps, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id name program_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[program steps user_completed_steps users users_techniques users_techniques_ratings]
  end
end
