class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :age, null: false
      t.text :description
      t.string :gender, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.belongs_to :coach, foreign_key: true
      t.belongs_to :program, foreign_key: true
      t.timestamps
    end
  end
end
