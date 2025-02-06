class Users::RestartStepService
  def initialize(params)
    @user_id = params[:user_id]
    @technique_id = params[:technique_id]
  end

  def perform
    uncomplete_users_technique
    destroy_steps
    find_first_step
  end

  private

  attr_reader :user_id, :technique_id

  def uncomplete_users_technique
    UsersTechnique.find_by(user_id: user_id, technique_id: technique_id)
                  .update(completed: false)
  end

  def destroy_steps
    UserCompletedStep.where(
      user_id: user_id, technique_id: technique_id
    ).destroy_all
  end

  def find_first_step
    step = Step.find_by(technique_id: technique_id, position: 0)
    step&.id
  end
end
