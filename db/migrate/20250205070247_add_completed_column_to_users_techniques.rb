class AddCompletedColumnToUsersTechniques < ActiveRecord::Migration[6.1]
  def change
    add_column :users_techniques, :completed, :boolean, default: false
    add_index :users_techniques, [:user_id, :technique_id], unique: true, name: "index_users_techniques_on_user_id_and_technique_id"
  end
end
