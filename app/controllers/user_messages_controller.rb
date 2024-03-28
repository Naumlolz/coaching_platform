class UserMessagesController < ApplicationController
  def index
    @messages = Message.where(user_id: current_user.id)
  end

  def create
    coach = current_user.coach
    service = Users::CreateMessageService.new(
      body: params[:body], user_id: current_user.id,
      coach_id: coach.id
    )
    service.perform
    redirect_to user_messages_path(user_id: params[:user_id])
    # SendUserMessageJob.perform_later(service)
  rescue ServiceError => e
    flash.now[:error] = e.message
    user_messages_path
    # SendUserMessageJob.perform_later(service)
  end
end
