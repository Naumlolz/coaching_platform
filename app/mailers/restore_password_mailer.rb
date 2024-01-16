class RestorePasswordMailer < ApplicationMailer
  default from: 'from@example.com'

  def send_otp_code
    @email = params[:email]
    @otp_code = params[:otp_code]
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end
end