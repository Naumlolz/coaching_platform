# coach message sending logic handler
class Coaches::CreateMessageService
  def initialize(params)
    @body = params[:body]
    @sent_by_coach = params[:sent_by_coach]
    @coach_id = params[:coach_id]
    @user_id = params[:user_id]
  end

  def perform
    message = create_message
    validate_message(message)
    message
  end

  private

  attr_reader :body, :sent_by_coach, :coach_id, :user_id

  def create_message
    Message.create(
      body: body, sent_by_coach: sent_by_coach,
      coach_id: coach_id, user_id: user_id
    )
  end

  def validate_message(message)
    raise ServiceError, 'Message is not valid' if message.invalid?
  end
end
