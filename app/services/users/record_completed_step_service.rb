class Users::RecordCompletedStepService
  def initialize(user_id, technique_id, step_id)
    @user_id = user_id
    @technique_id = technique_id
    @step_id = step_id
  end

  def perform
    check_step_validity
    create_completed_step
    search_for_next_step
  end

  private

  def check_step_validity
    @valid_step = Step.find_by(id: @step_id)
    raise ServiceError, "Validity error" if valid_step = nil
  end

  def create_completed_step
    UserCompletedStep.create(
      user_id: @user_id, technique_id: @technique_id,
      step_id: @step_id
    )
  end

  def search_for_next_step
    next_step_position = @valid_step.position + 1
    Step.find_by(
      technique_id: @technique_id,
      position: next_step_position
    )&.id
  end
end