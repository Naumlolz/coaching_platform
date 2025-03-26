# frozen_string_literal: true

# class for coaches authorization
class Coaches::SignInService
  def initialize(params)
    @email = params[:email]
    @password = params[:password]
    @session = params[:session]
  end

  def perform
    check_coach_not_nil
    hashed_password
    create_session
    check_coach_validation
  end

  private

  attr_reader :email, :password, :session

  def fetch_coach
    Coach.find_by(email: email)
  end

  def check_coach_not_nil
    raise ServiceError, 'The client with this email or password is not found' unless fetch_coach&.present?
  end

  def hashed_password
    BCrypt::Password.new(fetch_coach.password)
  end

  def create_session
    if hashed_password == password
      session[:member_type] = 'Coach'
      session[:member_id] = fetch_coach.id
    end
  end

  def check_coach_validation
    raise ServiceError, 'The client with this email or password is not found' if fetch_coach.invalid?
  end
end
