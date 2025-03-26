# class which handles technique rate notification
class Notifications::TechniqueRateNotificationService
  def initialize(params)
    @technique_id = params[:technique_id]
    @user = params[:user]
    @rate = params[:rate]
  end

  def perform
    create_notification
  end

  private

  attr_reader :user, :technique_id, :rate

  def create_notification
    Notification.create(
      user_id: user.id,
      coach_id: user.coach_id,
      message: "#{user.public_name} #{rate}s technique"
    )
  end
end
