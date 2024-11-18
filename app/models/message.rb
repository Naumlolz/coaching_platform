class Message < ApplicationRecord
  validates :body, :user_id, presence: true
  validates :sent_by_coach, inclusion: { in: [true, false] }

  belongs_to :user, optional: true
  belongs_to :coach
end
