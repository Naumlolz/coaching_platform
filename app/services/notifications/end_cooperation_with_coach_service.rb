# class which handles end cooperation notification
class Notifications::EndCooperationWithCoachService
  def initialize(params)
    @user_id = params[:user_id]
    @coach_id = params[:coach_id]
  end

  def perform
    create_notification
  end

  private

  attr_reader :user_id, :coach_id

  def create_notification
    Notification.create(
      user_id: user_id,
      coach_id: coach_id,
      message: "#{User.find(user_id).public_name} ends cooperation with you"
    )
  end
end
