class Technique < ApplicationRecord
  belongs_to :program
  has_many :users_techniques
  has_many :users_techniques_ratings
end
