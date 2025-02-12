class CreateUsersTechniquesTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :users_techniques_times do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :total_time_spent, default: 0
      t.timestamps
    end
  end
end
