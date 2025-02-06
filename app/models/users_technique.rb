class UsersTechnique < ApplicationRecord
  # validates :technique_status, presence: true, inclusion: {
  #   in: %w[not_started in_progress completed]
  # }

  belongs_to :user
  belongs_to :technique

  scope :completed, -> { where(completed: true) }
  scope :in_progress, -> { where(completed: false) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id technique_id technique_status updated_at user_id]
  end
end
