class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.string :title, null: false
      t.text :body
      t.integer :position
      t.belongs_to :technique, foreign_key: true
      t.timestamps
    end
  end
end
