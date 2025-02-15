class Notifications::MessageToCoachService
  def initialize(params)
    @user = params[:user]
  end

  def perform
    create_notification
  end

  private

  attr_reader :user

  def create_notification
    Notification.create(
      user_id: user.id,
      coach_id: user.coach_id,
      message: "#{user.public_name} sent you a message"
    )
  end
end
