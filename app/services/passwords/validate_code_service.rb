# frozen_string_literal: true

# class for validating 6-digit code according to users email
class Passwords::ValidateCodeService
  def initialize(params)
    @otp_code = params[:otp_code]
    @email = params[:email]
  end

  def perform
    check_not_nil_input
    check_otp_code_input
    check_otp_code_belongs_to_user
    check_otp_code_is_valid
  end

  private

  attr_reader :otp_code, :email

  def fetch_user
    User.find_by(email: email)
  end

  def check_not_nil_input
    raise ServiceError, 'Cant be blank' if otp_code.blank?
  end

  def check_otp_code_input
    otp_code_regex = /\A\d{6}\z/
    raise ServiceError, 'Incorrect otp_code input' unless otp_code.match?(otp_code_regex)
  end

  def check_otp_code_belongs_to_user
    raise ServiceError, 'Incorrect otp code' if otp_code != fetch_user.reset_password_code
  end

  def check_otp_code_is_valid
    raise ServiceError, 'Otp code expired' if Time.zone.now - fetch_user.reset_password_code_sent_at > 300
  end
end
