class UserProgramsController < ApplicationController
  def index
    @coach_programs = current_user.coach.programs
    @current_program = current_user.program
  end

  def update
    service = Users::ChooseProgramService.new(
      current_user, params[:id]
    )
    service.perform
    flash[:success] = 'The program is chosen'
    redirect_to users_dashboard_path
  rescue ServiceError => e
    flash[:error] = e.message
    redirect_to users_dashboard_path
  end
end
