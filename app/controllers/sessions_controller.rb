class SessionsController < ApplicationController
  include BCrypt

  def sign_in; end

  def sign_up; end

  def user_sign_in; end

  def user_perform_sign_in
    Users::SignInService.new(
      email:    params[:email],
      password: params[:password],
      session:  session
    ).perform
    flash[:success] = 'Sign in is successfull!'
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash[:error] = e.message
    render 'user_sign_in'
  end

  def user_sign_up; end

  def user_perform_sign_up
    service = Users::SignUpService.new(
      first_name:            params[:first_name],
      last_name:             params[:last_name],
      email:                 params[:email],
      password:              params[:password],
      password_confirmation: params[:password_confirmation]
    )
    service.perform
    flash[:success] = 'Thank you for signup! Now you can sign in!'
    redirect_to users_sign_in_path
  rescue ServiceError => e
    flash[:error] = e.message
    render 'user_sign_up'
  end

  def coach_sign_in; end

  def coach_perform_sign_in
    Coaches::SignInService.new(
      email:    params[:email],
      password: params[:password],
      session:  session
    ).perform
    flash[:success] = 'Sign in is successfull!'
    redirect_to coaches_dashboard_path
  rescue ServiceError => e
    flash[:error] = e.message
    render 'coach_sign_in'
  end

  def coach_sign_up; end

  def coach_perform_sign_up
    service = Coaches::SignUpService.new(
      first_name:            params[:first_name],
      last_name:             params[:last_name],
      email:                 params[:email],
      password:              params[:password],
      password_confirmation: params[:password_confirmation]
    )
    service.perform
    flash[:success] = 'Thank you for signup! Now you can sign in!'
    redirect_to coaches_sign_in_path
  rescue ServiceError => e
    flash[:error] = e.message
    render 'coach_sign_up'
  end

  def sign_out
    session[:member_type] = nil
    session[:member_id] = nil
    redirect_to root_path
  end
end
