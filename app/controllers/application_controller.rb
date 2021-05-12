class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :user_logged_in?
  helper_method :current_coach
  helper_method :coach_logged_in?
  
  def current_user
    return nil if session[:member_type] != 'User'
    User.find_by(id: session[:member_id])
  end

  def user_logged_in?
    !current_user.nil?  
  end

  def user_authorized?
    redirect_to new_session_path unless user_logged_in?
  end

  def current_coach
    return nil if session[:member_type] != 'Coach'
    Coach.find_by(id: session[:member_id])
  end

  def coach_logged_in?
    !current_coach.nil?  
  end

  def coach_authorized?
    redirect_to new_session_path unless coach_logged_in?
  end
end
