class Coaches::UpdatePasswordService
  def initialize(
    current_coach, old_password, new_password, new_password_confirmation
  )
    @coach = current_coach
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
    coach_db_password = BCrypt::Password.new(@coach.password)
    raise ServiceError, 'Password doesn`t match' if coach_db_password != @old_password

    raise ServiceError, 'New password doesn`t match' if @new_password != @new_password_confirmation
  end

  def update_password
    @coach.update(
      password: BCrypt::Password.create(@new_password)
    )
    raise ServiceError, 'Your password wasn`t updated' if @coach.invalid?
  end
end
