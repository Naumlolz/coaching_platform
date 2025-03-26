# frozen_string_literal: true

# class for coaches registration
class Coaches::SignUpService
  include BCrypt

  def initialize(params)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
  end

  def perform
    check_email_presence
    check_password_confirmation
    coach = create_coach
    check_coach_validation(coach)
  end

  private

  attr_reader :first_name, :last_name, :email, :password, :password_confirmation

  def check_email_presence
    raise ServiceError, 'This email is already taken' if User.find_by(email: email).present? ||
                                                        Coach.find_by(email: email).present?
  end

  def check_password_confirmation
    raise ServiceError, 'The password doesnt match' if password != password_confirmation
  end

  def create_coach
    Coach.create(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password.present? ? Password.create(password) : nil
    )
  end

  def check_coach_validation(coach)
    coach.validate_and_raise_error!
  end
end
