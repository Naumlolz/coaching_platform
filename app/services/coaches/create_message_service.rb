class Coaches::CreateMessageService
  def initialize(params)
    @body = params[:body]
    @sent_by_coach = params[:sent_by_coach]
    @coach_id = params[:coach_id]
    @user_id = params[:user_id]
  end

  def perform
    create_message
    message_validation
  end

  private

  def create_message
    @message = Message.create(
      body: @body, sent_by_coach: @sent_by_coach,
      coach_id: @coach_id, user_id: @user_id
    )
  end

  def message_validation
    raise ServiceError, 'Message is not valid' if @message.invalid?
  end
end