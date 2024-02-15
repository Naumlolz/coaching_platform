# frozen_string_literal: true

# class for users authorization
class Users::SignInService
  include BCrypt

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
    @session = params[:session]
  end

  def perform
    check_user_not_nil
    hashed_password
    create_session
    check_user_validation
  end

  private

  attr_reader :email, :password, :session

  def fetch_user
    User.find_by(email: email)
  end

  def check_user_not_nil
    raise ServiceError, 'The client with this email or password is not found' if fetch_user.nil?
  end

  def hashed_password
    BCrypt::Password.new(fetch_user.password)
  end

  def create_session
    if hashed_password == password
      session[:member_type] = 'User'
      session[:member_id] = fetch_user.id
    end
  end

  def check_user_validation
    raise ServiceError, 'The client with this email or password is not found' if fetch_user.invalid?
  end
end
