# controller which represents actions with users programs
class UserProgramsController < ApplicationController
  def index
    @coach_programs = current_user.coach.programs
    @current_program = current_user.program
  end

  def update
    Users::ChooseProgramService.new(
      user: current_user,
      program_id: params[:id]
    ).perform
    flash[:success] = I18n.t('success_messages.program_chosen') 
  rescue ServiceError => error
    flash[:error] = error.message
  ensure
    redirect_to users_dashboard_path
  end
end
