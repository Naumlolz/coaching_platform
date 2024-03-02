# frozen_string_literal: true

# class for updating coache's password
class Coaches::UpdatePasswordService
  def initialize(params)
    @coach = params[:coach]
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

  attr_reader :coach, :old_password, :new_password, :new_password_confirmation

  def check_old_password
    coach_db_password = BCrypt::Password.new(coach.password)
    raise ServiceError, 'Password doesnt match' if coach_db_password != old_password
  end

  def check_new_password
    raise ServiceError, 'New password doesnt match' if new_password != new_password_confirmation
  end

  def update_password
    coach.update(
      password: BCrypt::Password.create(new_password)
    )
    raise ServiceError, 'Your password wasnt updated' if coach.invalid?
  end
end
