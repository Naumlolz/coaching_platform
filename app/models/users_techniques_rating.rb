# The UsersTechniquesRating class represents the ratings that users give to various techniques
class UsersTechniquesRating < ApplicationRecord
  validates :rate, presence: true
  validates :rate, inclusion: { in: %w[like dislike] }

  belongs_to :user
  belongs_to :technique

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id rate technique_id updated_at user_id]
  end
end
