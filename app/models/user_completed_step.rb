class UserCompletedStep < ApplicationRecord
  belongs_to :user
  belongs_to :step
  belongs_to :technique

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id step_id technique_id updated_at user_id]
  end

  def time_spent
    return nil unless start_time && end_time
    end_time - start_time
  end
end
