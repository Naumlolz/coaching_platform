# controller which represents actions with users messages
class UserMessagesController < ApplicationController
  def index
    @messages = Message.where(user_id: current_user.id)
  end

  def create
    user_id = current_user.id
    coach = current_user.coach

    message = create_message(user_id: user_id, coach: coach, body: params[:body])
    send_notification(user_id: user_id)
    broadcast_message(message: message)

    head :no_content

    # respond_to do |format|
    #   format.js { @message }
    # end

    # redirect_to user_messages_path(user_id: params[:user_id])
  rescue ServiceError => error
    flash.now[:error] = error.message
    user_messages_path
  end

  private

  def create_message(user_id:, coach:, body:)
    service = Users::CreateMessageService.new(body: body, user_id: user_id, coach_id: coach.id)
    service.perform
  end

  def send_notification(user_id:)
    Notifications::MessageToCoachWorker.perform_async(user_id)
  end

  def broadcast_message(message:)
    serialized_message = MessageSerializer.new(message).as_json
    ActionCable.server.broadcast('messages_channel', serialized_message)
  end
end
