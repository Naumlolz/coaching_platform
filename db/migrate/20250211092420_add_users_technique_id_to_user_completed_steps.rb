class AddUsersTechniqueIdToUserCompletedSteps < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_completed_steps, :users_technique, foreign_key: true
  end
end
