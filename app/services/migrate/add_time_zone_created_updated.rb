class Migrate::AddTimeZoneCreatedUpdated < ActiveRecord::Migration[6.1]
  def self.up(table)  
    if ActiveRecord::Base.connection.column_exists?(table.to_sym, :created_at)
      execute <<-SQL
        ALTER TABLE #{table} ALTER created_at TYPE timestamptz USING created_at AT TIME ZONE 'Europe/Moscow';
      SQL
    end

    if ActiveRecord::Base.connection.column_exists?(table.to_sym, :updated_at)
      execute <<-SQL
        ALTER TABLE #{table} ALTER updated_at TYPE timestamptz USING updated_at AT TIME ZONE 'Europe/Moscow';
      SQL
    end
  end

  def self.down
    say_with_time("<--- Миграция без обратного процесса") do; end
  end
end
