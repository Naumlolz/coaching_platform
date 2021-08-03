class RemoveExpertiseFromCoaches < ActiveRecord::Migration[6.1]
  def change
    remove_column :coaches, :expertise, :string
  end
end
