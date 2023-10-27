class CoachesController < ApplicationController
  def dashboard
    redirect_to coaches_finish_profile_path if current_coach.age.blank?
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
    service = Coaches::UpdateExpertiseService.new(
      coach_id: current_coach.id, program_ids: coaches_programs_ids
    )
    service.perform
    redirect_to coaches_profile_path
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
      :first_name, :last_name, :age, :avatar,
      :education, :experience, :certificate
    )
  end

  def change_password; end

  def update_password
    service = Coaches::UpdatePasswordService.new(
      current_coach, params[:old_password], params[:new_password],
      params[:new_password_confirmation]
    )
    service.call
    redirect_to coaches_dashboard_path
  rescue ServiceError => e
    flash.now[:error] = e.message
    render 'change_password'
  end

  def my_users
    @users = current_coach.users
  end

  def waiting_for_confirmation
    @current_coach_invitations = current_coach.users_coaches_invitations.where(accepted: nil)
  end

  def accept_invite
    invite = Coaches::AcceptInviteService.new(current_coach.id, params[:invitation_id])
    invite.call
    flash[:success] = 'You`ve assigned user!'
    redirect_to coaches_waiting_for_confirmation_path
  rescue ServiceError => e
    flash[:error] = e.message
    redirect_to coaches_waiting_for_confirmation_path
  end

  def decline_invite
    declined_invite = UsersCoachesInvitation.find_by(id: params[:invitation_id])
    declined_invite.update(
      accepted: false
    )
    redirect_to coaches_waiting_for_confirmation_path
  end
end
