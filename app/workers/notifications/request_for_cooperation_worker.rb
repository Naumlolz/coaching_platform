class Notifications::RequestForCooperationWorker < Notifications::Notification
  def perform(user_id, coach_id)
    Notifications::RequestForCooperationNotificationService.new(
      user_id: user_id,
      coach_id: coach_id
    ).perform
  end
end
