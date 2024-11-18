class Step < ApplicationRecord
  validates :title, :body, :position, presence: true

  belongs_to :technique
  has_many :user_completed_steps, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[body created_at id position technique_id title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[technique user_completed_steps]
  end
end
