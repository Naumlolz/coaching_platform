# The UsersTechniquesRating class represents the ratings that users give to various techniques
class UsersTechniquesRating < ApplicationRecord
  validates :rate, presence: true
  validates :rate, inclusion: { in: %w[like dislike] }

  belongs_to :user
  belongs_to :technique

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id rate technique_id updated_at user_id]
  end

  def self.find_or_initialize_rating(user_id:, technique_id:)
    find_or_initialize_by(
      user_id: user_id,
      technique_id: technique_id
    )
  end

  def save_with_notification(rate:, user_id:, technique_id:)
    self.rate = rate
    save!
    Notifications::EnqueueNotificationService.new(user_id: user_id, technique_id: technique_id, rate: rate).perform
  end
end
