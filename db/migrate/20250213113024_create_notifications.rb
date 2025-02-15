class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, null: false
      t.belongs_to :coach, null: false
      t.string :message, null: false
      t.boolean :read, default: false
      t.string "on_click_url"
      t.timestamps
    end
  end
end
