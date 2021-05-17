class UsersController < ApplicationController
  include BCrypt

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

  def profile
  end

  def update_profile
    updated_user = current_user
    updated_user.update(user_params)
    if updated_user.valid?
      flash[:success] = 'Your profile was updated'
      redirect_to users_profile_path
    else
      @errors = updated_user.errors.full_messages
      render 'profile'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :avatar)
  end

  def change_password
  end

  def update_password
    service = Users::UpdatePasswordService.new(
      current_user, params[:old_password], params[:new_password],
      params[:new_password_confirmation]
    )
    service.call
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash.now[:error] = e.message
    render 'change_password'
  end
end