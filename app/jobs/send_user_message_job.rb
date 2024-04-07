class SendUserMessageJob < ApplicationJob
  queue_as :default

  def perform(service)
    html = "<p>#{service.body}</p>"
    chat_id = [service.user_id, service.coach_id].sort.join("")
    ActionCable.server.broadcast("message_channel_#{chat_id}", html: html)
  end
end