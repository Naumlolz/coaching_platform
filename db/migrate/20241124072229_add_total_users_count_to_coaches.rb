class AddTotalUsersCountToCoaches < ActiveRecord::Migration[6.1]
  def change
    add_column :coaches, :total_users_count, :integer, default: 0
  end
end
