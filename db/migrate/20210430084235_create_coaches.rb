class CreateCoaches < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :description
      t.integer :age, null: false
      t.string :gender, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :expertise, null: false
      t.string :education, null: false
      t.string :experience, null: false
      t.string :certificate, null: false
      t.timestamps
    end
  end
end
