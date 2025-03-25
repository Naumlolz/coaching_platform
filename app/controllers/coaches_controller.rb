# class which represents coach actions logic
class CoachesController < ApplicationController
  def dashboard
    redirect_to coaches_finish_profile_path if current_coach.age.blank?

    @coach = current_coach
  end

  def finish_profile; end

  def finish_coach_profile
    coach = current_coach
    coach.update(
      age: params[:age],
      gender: params[:gender],
      description: params[:description],
      education: params[:education],
      experience: params[:experience],
      certificate: params[:certificate]
    )
    redirect_to coaches_dashboard_path
  end

  def profile; end

  def update_expertise
    coaches_programs_ids = params[:coach][:program_ids].reject(&:empty?)
    Coaches::UpdateExpertiseService.new(
      coach_id: current_coach.id, program_ids: coaches_programs_ids
    ).perform
    redirect_to coaches_profile_path
  end

  def update_profile
    current_coach.update(coach_params)
    if current_coach.valid?
      flash[:success] = 'Your profile was updated'
      redirect_to coaches_profile_path
    else
      @errors = current_coach.errors.full_messages
      render 'profile'
    end
  end

  def coach_params
    params.require(:coach).permit(
      :first_name, :last_name, :age, :avatar,
      :education, :experience, :certificate
    )
  end

  def change_password; end

  def update_password
    Coaches::UpdatePasswordService.new(password_update_params).call
    redirect_to coaches_dashboard_path
  rescue ServiceError => error
    flash.now[:error] = error.message
    render 'change_password'
  end

  def my_users
    @users = current_coach.users
  end

  def waiting_for_confirmation
    @current_coach_invitations = current_coach.users_coaches_invitations.where(accepted: nil)
  end

  def accept_invite
    Coaches::AcceptInviteService.new(
      coach_id: current_coach.id,
      invite_id: params[:invitation_id]
    ).call
    flash[:success] = I18n.t('success_messages.successfull_assigned_user')
  rescue ServiceError => error
    flash[:error] = error.message
  ensure
    redirect_to coaches_waiting_for_confirmation_path
  end

  def decline_invite
    declined_invite = UsersCoachesInvitation.find_by(id: params[:invitation_id])
    declined_invite.update(
      accepted: false
    )
    redirect_to coaches_waiting_for_confirmation_path
  end

  private

  def password_update_params
    {
      coach: current_coach,
      old_password: params[:old_password],
      new_password: params[:new_password],
      new_password_confirmation: params[:new_password_confirmation]
    }
  end
end
