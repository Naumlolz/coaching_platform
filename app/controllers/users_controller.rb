class UsersController < ApplicationController
  def dashboard
    redirect_to users_finish_profile_path if current_user.age.blank?
  end

  def finish_profile
  end

  def finish_user_profile
    user = current_user
    user.update(
      age: params[:age],
      gender: params[:gender],
      description: params[:description],
    )
    redirect_to users_dashboard_path
  end
end