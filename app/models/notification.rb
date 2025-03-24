# class which represents notifications
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :coach

  validates :message, presence: true
end
