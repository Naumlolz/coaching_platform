class UserMessagesController < ApplicationController
  def index
    @messages = Message.where(user_id: current_user.id)
  end

  def create
    user = current_user
    coach = user.coach
    service = Users::CreateMessageService.new(
      body: params[:body], user_id: user.id,
      coach_id: coach.id
    )
    service.perform
    SendUserMessageJob.perform_later(service)
  rescue ServiceError => e
    flash.now[:error] = e.message
    SendUserMessageJob.perform_later(service)
  end
end