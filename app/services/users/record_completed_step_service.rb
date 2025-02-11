class Users::RecordCompletedStepService
  def initialize(params)
    @user_id = params[:user_id]
    @technique_id = params[:technique_id]
    @step_id = params[:step_id]
    @end_time = params[:end_time]
  end

  def perform
    check_step_validity
    create_completed_step
    search_for_next_step
  end

  private

  attr_reader :user_id, :step_id, :technique_id, :end_time

  def check_step_validity
    @valid_step = Step.find_by(id: step_id)
    raise ServiceError, 'Validity error' if @valid_step.nil?
  end

  def create_completed_step
    UserCompletedStep.find_or_initialize_by(
      user_id: user_id, technique_id: technique_id,
      step_id: step_id)
                      .update(end_time: Time.zone.now)
  end

  def search_for_next_step
    next_step_position = @valid_step.position + 1
    Step.find_by(
      technique_id: technique_id,
      position: next_step_position
    )&.id
  end
end
