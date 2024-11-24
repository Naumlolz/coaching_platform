# frozen_string_literal: true

# class for setting up new users password
class Passwords::SetNewPasswordService
  include BCrypt

  def initialize(params)
    @email = params[:email]
    @new_password = params[:new_password]
    @new_password_confirmation = params[:new_password_confirmation]
  end

  def perform
    check_not_nil_input
    check_password_inputs
    set_new_password
  end

  private

  attr_reader :email, :new_password, :new_password_confirmation

  def fetch_user
    User.find_by(email: email)
  end

  def check_not_nil_input
    raise ServiceError, 'Cant be blank' if new_password.blank? || new_password_confirmation.blank?
  end

  def check_password_inputs
    raise ServiceError, 'Password confirmation must match password' if
      new_password.strip != new_password_confirmation.strip
  end

  def set_new_password
    fetch_user.update(
      password: BCrypt::Password.create(new_password)
    )
    raise ServiceError, 'Your password wasn`t updated' if fetch_user.invalid?
  end
end
