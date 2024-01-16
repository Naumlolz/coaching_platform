class RestorePasswordJob < ApplicationJob
  queue_as :default

  def perform(params)
    RestorePasswordMailer.with(
      otp_code: params[:otp_code],
      email: params[:email]
    ).send_otp_code.deliver_now
  end
end
