class CreateCoaches < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :description
      t.integer :age
      t.string :gender
      t.string :email, null: false
      t.string :password, null: false
      t.string :expertise
      t.string :education
      t.string :experience
      t.string :certificate
      t.timestamps
    end
  end
end
