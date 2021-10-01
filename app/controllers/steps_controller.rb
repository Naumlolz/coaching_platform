class StepsController < ApplicationController
  def show
    @step = Step.find(params[:id])
    @current_technique = @step.technique
  end

  def perform_complete
    service = Users::RecordCompletedStepService.new(
      current_user.id, params[:id], step.technique.id
    )
    service.perform
    redirect_to step_path
  end
end