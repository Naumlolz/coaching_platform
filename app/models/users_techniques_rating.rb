class UsersTechniquesRating < ApplicationRecord
  belongs_to :user
  belongs_to :technique
end
