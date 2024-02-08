# frozen_string_literal: true

# class for updating users password
class Users::UpdatePasswordService
  def initialize(params)
    @user = params[:user]
    @old_password = params[:old_password]
    @new_password = params[:new_password]
    @new_password_confirmation = params[:new_password_confirmation]
  end

  def call
    check_old_password
    check_new_password
    update_password
  end

  private

  attr_reader :user, :old_password, :new_password, :new_password_confirmation

  def check_old_password
    user_db_password = BCrypt::Password.new(user.password)
    raise ServiceError, 'Password doesn`t match' if user_db_password != old_password
  end

  def check_new_password
    raise ServiceError, 'New password doesnt match' if new_password != new_password_confirmation
  end

  def update_password
    user.update(
      password: BCrypt::Password.create(new_password)
    )
    raise ServiceError, 'Your password wasn`t updated' if user.invalid?
  end
end
