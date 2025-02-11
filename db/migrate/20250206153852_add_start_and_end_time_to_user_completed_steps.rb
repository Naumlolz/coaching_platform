class AddStartAndEndTimeToUserCompletedSteps < ActiveRecord::Migration[6.1]
  def change
    change_table :user_completed_steps, bulk: true do |t|
      t.column :start_time, :datetime
      t.column :end_time, :datetime
    end
  end
end
