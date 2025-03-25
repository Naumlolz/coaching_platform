# class which represents authentication and authorization logic
class SessionsController < ApplicationController
  include BCrypt

  def sign_in; end

  def sign_up; end

  def user_sign_in; end

  def user_perform_sign_in
    Users::SignInService.new(
      email: params[:email],
      password: params[:password],
      session: session
    ).perform
    flash[:success] = I18n.t('success_messages.successfull_sign_in')
    redirect_to users_dashboard_path
  rescue ServiceError => error
    flash[:error] = error.message
    render 'user_sign_in'
  end

  def user_sign_up; end

  def user_perform_sign_up
    service = Users::SignUpService.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    service.perform
    flash[:success] = I18n.t('success_messages.successfull_sign_up')
    redirect_to users_sign_in_path
  rescue ServiceError => error
    flash[:error] = error.message
    render 'user_sign_up'
  end

  def coach_sign_in; end

  def coach_perform_sign_in
    Coaches::SignInService.new(
      email: params[:email],
      password: params[:password],
      session: session
    ).perform
    flash[:success] = I18n.t('success_messages.successfull_sign_in')
    redirect_to coaches_dashboard_path
  rescue ServiceError => error
    flash[:error] = error.message
    render 'coach_sign_in'
  end

  def coach_sign_up; end

  def coach_perform_sign_up
    coach_sign_up_service.perform
    handle_sign_up_success
  rescue ServiceError => error
    handle_sign_up_failure(error)
  end

  def sign_out
    session[:member_type] = nil
    session[:member_id] = nil
    redirect_to root_path
  end

  private

  def coach_sign_up_service
    Coaches::SignUpService.new(coach_sign_up_params)
  end

  def coach_sign_up_params
    {
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    }
  end

  def handle_sign_up_success
    flash[:success] = I18n.t('success_messages.successfull_sign_up')
    redirect_to coaches_sign_in_path
  end

  def handle_sign_up_failure(error)
    flash[:error] = error.message
    render 'coach_sign_up'
  end
end
