class CoachesProgram < ApplicationRecord
  belongs_to :coach
  belongs_to :program

  def self.ransackable_attributes(_auth_object = nil)
    %w[coach_id created_at id program_id updated_at]
  end
end
