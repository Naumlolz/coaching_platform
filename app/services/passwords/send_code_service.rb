# frozen_string_literal: true

# class for sending 6-digit code to users email
class Passwords::SendCodeService
  def initialize(params)
    @email = params[:email]
  end

  def perform
    check_not_nil_input
    remove_spaces
    check_email_input
    check_email_exists_in_db
    send_mail
  end

  private

  attr_reader :email

  def check_not_nil_input
    raise ServiceError, 'Cant be blank' if email.blank?
  end

  def remove_spaces
    email.strip!
  end

  def check_email_input
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    raise ServiceError, 'Incorrect email input' unless email.match?(email_regex)
  end

  def check_email_exists_in_db
    raise ServiceError, 'User not existing' unless User.exists?(email: email)
  end

  def generate_otp_code
    OtpCode::OtpCodeGenerator.generate_otp_code
  end

  def send_mail
    otp_code = generate_otp_code
    RestorePasswordJob.perform_now(
      email: email,
      otp_code: otp_code
    )
    update_user(otp_code)
  end

  def update_user(otp_code)
    User.find_by(email: email).update(
      reset_password_code: otp_code,
      reset_password_code_sent_at: Time.zone.now
    )
  end
end
