class UserCompletedStep < ApplicationRecord
  validates :user_id, :step_id, :technique_id, presence: true

  belongs_to :user
  belongs_to :step
  belongs_to :technique
end
