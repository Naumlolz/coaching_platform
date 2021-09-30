class Step < ApplicationRecord
  validates :title, :body, :technique_id, :position, presence: true

  belongs_to :technique
  has_many :user_completed_steps
end
