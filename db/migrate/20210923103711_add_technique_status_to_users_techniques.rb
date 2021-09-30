class AddTechniqueStatusToUsersTechniques < ActiveRecord::Migration[6.1]
  def change
    add_column :users_techniques, :technique_status, :string
  end
end
