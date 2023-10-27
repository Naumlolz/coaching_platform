class UsersTechnique < ApplicationRecord
  validates :user_id, :technique_id, presence: true
  validates :technique_status, presence: true, inclusion: {
    in: %w[not_started in_progress completed]
  }

  belongs_to :user
  belongs_to :technique
end
