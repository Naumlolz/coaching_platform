# class which handles enqueue notification
class Notifications::EnqueueNotificationService
  def initialize(user_id:, technique_id:, rate:)
    @user_id = user_id
    @technique_id = technique_id
    @rate = rate
  end

  def perform
    enqueue_notification
  end

  private

  attr_reader :user_id, :technique_id, :rate

  def enqueue_notification
    Notifications::TechniqueRateNotificationWorker.perform_async(
      user_id: user_id,
      technique_id: technique_id,
      rate: rate
    )
  end
end