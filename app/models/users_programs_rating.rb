class UsersProgramsRating < ApplicationRecord
  belongs_to :user
  belongs_to :program

  validates :rating_type, presence: true
  validates :rating_type, inclusion: { in: %w[like dislike] }
end
