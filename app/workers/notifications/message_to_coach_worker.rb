class Notifications::MessageToCoachWorker < Notifications::Notification
  def perform(user_id)
    user = User.find(user_id)

    Notifications::MessageToCoachService.new(user: user).perform
  end
end
