class UsersTechnique < ApplicationRecord
  validates :user_id, :technique_id, presence: true

  belongs_to :user
  belongs_to :technique
end
