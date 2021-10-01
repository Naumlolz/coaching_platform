class Users::RecordCompletedStepService
  def initialize(user_id, technique_id, step_id)
    @user_id = user_id
    @technique_id = technique_id
    @step_id = step_id
  end

  def perform
    
  end

  private

  def create_completed_step
    UserCompletedStep.create(
      user_id: @user_id, technique_id: @technique_id,
      step_id: @step_id
    )
  end
end