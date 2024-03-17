class UserProgramsController < ApplicationController
  def index
    @coach_programs = current_user.coach.programs
    @current_program = current_user.program
  end

  def update
    Users::ChooseProgramService.new(
      user:       current_user,
      program_id: params[:id]
    ).perform
    flash[:success] = 'The program is chosen'
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash[:error] = e.message
    redirect_to users_dashboard_path
  end
end
