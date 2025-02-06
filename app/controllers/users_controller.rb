class UsersController < ApplicationController
  include BCrypt

  def dashboard
    redirect_to users_finish_profile_path if current_user.age.blank?

    @user = current_user
  end

  def finish_profile; end

  def finish_user_profile
    user = current_user
    user.update(
      age: params[:age],
      gender: params[:gender],
      description: params[:description]
    )
    redirect_to users_dashboard_path
  end

  def forget_password; end

  def profile; end

  def update_profile
    updated_user = current_user
    updated_user.update(user_params)
    if updated_user.valid?
      flash[:success] = I18n.t('success_messages.profile_updated')
      redirect_to users_profile_path
    else
      @errors = updated_user.errors.full_messages
      render 'profile'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :avatar)
  end

  def change_password; end

  def update_password
    Users::UpdatePasswordService.new(
      user: current_user,
      old_password: params[:old_password],
      new_password: params[:new_password],
      new_password_confirmation: params[:new_password_confirmation]
    ).call
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash.now[:error] = e.message
    render 'change_password'
  end

  def all_coaches
    @coaches = Coach.all
    @current_coach = current_user.coach
  end

  def invite_coach
    Users::InviteCoachService.new(
      user: current_user, coach_id: params[:coach_id]
    ).call
    flash[:success] = I18n.t('success_messages.invitation_sent')
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash[:error] = e.message
    redirect_to users_dashboard_path
  end

  def unassign_coach
    user = current_user
    user.update(
      coach_id: nil
    )
    redirect_to users_all_coaches_path
  end
end
