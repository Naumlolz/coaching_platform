class Users::CreateMessageService
  def initialize(params)
    @body = params[:body]
    @user_id = params[:user_id]
    @coach_id = params[:coach_id]
  end

  def perform
    create_message
    message_validation
  end

  private

  def create_message
    @message = Message.create(
      body: @body, user_id: @user_id,
      coach_id: @coach_id
    )
  end

  def message_validation
    raise ServiceError, 'Message is not valid' if @message.invalid?
  end
end