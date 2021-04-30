class CreateTechniques < ActiveRecord::Migration[6.1]
  def change
    create_table :techniques do |t|
      t.string :name, null: false
      t.text :description
      t.belongs_to :program, foreign_key: true
      t.timestamps
    end
  end
end
