class AddUniqueEmailIndexToUsersAndCoaches < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true
    add_index :coaches, :email, unique: true
  end
end
