class MessageSerializer
  def initialize(message)
    @message = message
  end

  def as_json
    return nil unless @message

    {
      id: @message.id,
      body: @message.body,
      sent_by_coach: @message.sent_by_coach,
      user_id: @message.user_id,
      coach_id: @message.coach_id,
      created_at: @message.created_at.strftime('%Y-%m-%d %H:%M:%S')
    }
  end
end
