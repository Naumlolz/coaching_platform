class StepsController < ApplicationController
  def show
    @step = Step.find(params[:id])
    @current_technique = @step.technique
  end

  def perform_complete
    service = Users::RecordCompletedStepService.new(
      current_user.id,
      params[:technique_id],
      params[:id]
    )
    next_step_id = service.perform
    if next_step_id.present?
      redirect_to step_path(next_step_id)
    else
      redirect_to user_techniques_path
    end
  rescue ServiceError => e
    flash.now[:error] = e.message
    redirect_to user_techniques_path
  end

  def restart
    service = Users::RestartStepService.new(
      user_id: current_user.id,
      technique_id: params[:technique_id]
    )
    first_step_id = service.perform
    redirect_to step_path(first_step_id)
  end
end