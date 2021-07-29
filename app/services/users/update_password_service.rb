class Users::UpdatePasswordService
  def initialize(
    current_user, old_password, new_password, new_password_confirmation
  )
    @user = current_user
    @old_password = old_password
    @new_password = new_password
    @new_password_confirmation = new_password_confirmation
  end

  def call
    check_old_password
    update_password
  end

  private

  def check_old_password
    user_db_password = BCrypt::Password.new(@user.password)
    if user_db_password != @old_password
      raise ServiceError, 'Password doesn`t match'
    end
    if @new_password != @new_password_confirmation
      raise ServiceError, 'New password doesn`t match'
    end
  end

  def update_password
    @user.update(
      password: BCrypt::Password.create(@new_password)
    )
    raise ServiceError, 'Your password wasn`t updated' if @user.invalid?
  end
end
