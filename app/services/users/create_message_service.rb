# user create message logic
class Users::CreateMessageService
  def initialize(params)
    @body = params[:body]
    @user_id = params[:user_id]
    @coach_id = params[:coach_id]
  end

  def perform
    message = create_message
    validate_message(message)
    message
  end

  private

  attr_reader :body, :user_id, :coach_id

  def create_message
    Message.create(
      body: body, user_id: user_id,
      coach_id: coach_id
    )
  end

  def validate_message(message)
    raise ServiceError, 'Message is not valid' if message.invalid?
  end
end
