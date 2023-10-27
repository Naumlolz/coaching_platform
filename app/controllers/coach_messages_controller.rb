class CoachMessagesController < ApplicationController
  def index
    @user_id = params[:user_id]
    @messages = Message.where(coach_id: current_coach.id, user_id: @user_id)
  end

  def create
    service = Coaches::CreateMessageService.new(
      body: params[:body], sent_by_coach: true,
      coach_id: current_coach.id, user_id: params[:user_id]
    )
    service.perform
    redirect_to coach_messages_path(user_id: params[:user_id])
  rescue ServiceError => e
    flash.now[:error] = e.message
    redirect_to coach_messages_path
  end
end
