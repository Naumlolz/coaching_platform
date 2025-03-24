# class which represents users_techniques
class UsersTechnique < ApplicationRecord
  # validates :technique_status, presence: true, inclusion: {
  #   in: %w[not_started in_progress completed]
  # }

  belongs_to :user
  belongs_to :technique
  has_many :user_completed_steps, dependent: :destroy

  scope :completed, -> { where(completed: true) }
  scope :in_progress, -> { where(completed: false) }

  scope :sorted_by_progress, -> {
    left_joins(:user_completed_steps)
      .group(:id)
      .order(Arel.sql('COUNT(user_completed_steps.id) DESC NULLS LAST'))
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id technique_id technique_status updated_at user_id]
  end
end
