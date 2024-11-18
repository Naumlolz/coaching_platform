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
    message = service.perform
    @message = message
    serialized_message = serialize_message(message)

    ActionCable.server.broadcast 'messages_channel', serialized_message
    head :no_content

    # respond_to do |format|
    #   format.js { @message }
    # end

    # redirect_to user_messages_path(user_id: params[:user_id])
  rescue ServiceError => e
    flash.now[:error] = e.message
    user_messages_path
  end

  private

  def serialize_message(message)
    return nil unless message

    {
      id: message.id,
      body: message.body,
      sent_by_coach: message.sent_by_coach,
      user_id: message.user_id,
      coach_id: message.coach_id,
      created_at: message.created_at.strftime("%Y-%m-%d %H:%M:%S")
    }
  end
end
