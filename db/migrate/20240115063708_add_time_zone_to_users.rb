class AddTimeZoneToUsers < ActiveRecord::Migration[6.1]
  def up
    Migrate::AddTimeZoneCreatedUpdated.up("users")
    change_column :users, :reset_password_code_sent_at, :timestamptz
  end

  def down
    Migrate::AddTimeZoneCreatedUpdated.down
  end
end
