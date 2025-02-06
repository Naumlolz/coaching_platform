class StepsController < ApplicationController
  def show
    @step = Step.find(params[:id])
    @current_technique = @step.technique
  end

  def perform_complete
    service = Users::RecordCompletedStepService.new(
      user_id: current_user.id,
      technique_id: params[:technique_id],
      step_id: params[:id]
    )
    next_step_id = service.perform
    if next_step_id.present?
      redirect_to step_path(next_step_id)
    else
      # redirect_to user_techniques_path
      @show_modal = true
      @step = Step.find(params[:id])
      @current_technique = @step.technique
      UsersTechnique.find_by(technique_id: @current_technique.id, user_id: current_user.id)
                    .update(completed: true)
      render action: :show
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
