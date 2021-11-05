class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :body, null: :false
      t.boolean :sent_by_coach, default: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :coach, foreign_key: true
      t.timestamps
    end
  end
end
