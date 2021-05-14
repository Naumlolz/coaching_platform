class CoachesController < ApplicationController
  def dashboard
    redirect_to coaches_finish_profile_path if current_coach.age.blank?
  end

  def finish_profile
  end

  def finish_coach_profile
    coach = current_coach
    coach.update(
      age: params[:age],
      gender: params[:gender],
      description: params[:description],
      expertise: params[:expertise],
      education: params[:education],
      experience: params[:experience],
      certificate: params[:certificate],
    )
    redirect_to coaches_dashboard_path
  end

  def profile
  end

  def update_profile
    updated_coach = current_coach
    updated_coach.update(coach_params)
    if updated_coach.valid?
      flash[:success] = 'Your profile was updated'
      redirect_to coaches_profile_path
    else
      @errors = updated_coach.errors.full_messages
      render 'profile'
    end
  end

  def coach_params
    params.require(:coach).permit(
      :first_name, :last_name, :age, :avatar, :expertise,
      :education, :experience, :certificate
    )
  end

  def change_password
  end

  def update_password
    updated_password_coach = current_coach
    old_password = params[:old_password]
    coach_db_password = BCrypt::Password.new(updated_password_coach.password)
    if coach_db_password != old_password
      flash[:error] = 'Password doesn`t match'
      render 'change_password' and return
    end

    if params[:new_password] != params[:new_password_confirmation]
      flash[:error] = 'New password doesn`t match'
      render 'change_password' and return
    end
    updated_password_coach.update(
      password: BCrypt::Password.create(params[:new_password])
    )
    if updated_password_coach.valid?
      flash[:success] = 'Your password was updated'
      redirect_to coaches_dashboard_path
    else
      @errors = updated_password_coach.errors.full_messages
      render 'change_password'
    end
  end
end