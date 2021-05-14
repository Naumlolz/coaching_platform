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
    updated_password_user = current_user
    old_password = params[:old_password]
    user_db_password = BCrypt::Password.new(updated_password_user.password)
    if user_db_password != old_password
      flash[:error] = 'Password doesn`t match'
      render 'change_password' and return
    end

    if params[:new_password] != params[:new_password_confirmation]
      flash[:error] = 'New password doesn`t match'
      render 'change_password' and return
    end
    updated_password_user.update(
      password: BCrypt::Password.create(params[:new_password])
    )
    if updated_password_user.valid?
      flash[:success] = 'Your password was updated'
      redirect_to users_dashboard_path
    else
      @errors = updated_password_user.errors.full_messages
      render 'change_password'
    end
  end
end