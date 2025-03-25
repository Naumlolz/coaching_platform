# controller which represents actions with steps
class StepsController < ApplicationController
  before_action :set_current_technique, only: [:show]
  before_action :set_start_time, only: [:show]

  def show
    find_step
  end

  def perform_complete
    user_id = current_user.id
    service = Users::RecordCompletedStepService.new(
      user_id: user_id,
      technique_id: params[:technique_id],
      step_id: params[:id]
    )
    next_step_id = service.perform
    if next_step_id.present?
      redirect_to step_path(next_step_id)
    else
      # redirect_to user_techniques_path
      @show_modal = true
      UsersTechnique.find_by(technique_id: set_current_technique.id, user_id: user_id)
                    .update(completed: true)
      render action: :show
    end
  rescue ServiceError => error
    flash.now[:error] = error.message
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

  private

  def find_step
    @step = Step.find(params[:id])
  end

  def set_current_technique
    @current_technique = find_step.technique
  end

  def fetch_users_technique
    UsersTechnique.find_by(
      user_id: current_user.id,
      technique_id: set_current_technique.id
    )
  end

  def set_start_time
    UserCompletedStep.find_or_initialize_by(
      user_id: current_user.id,
      technique_id: set_current_technique.id,
      step_id: find_step.id,
      users_technique_id: fetch_users_technique.id
    ).update(start_time: Time.zone.now)
  end
end
