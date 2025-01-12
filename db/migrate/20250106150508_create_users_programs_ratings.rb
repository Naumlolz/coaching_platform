class CreateUsersProgramsRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :users_programs_ratings do |t|
      t.string :rating_type, null: false
      t.references :user, null: false, foreign_key: true
      t.references :program, null: false, foreign_key: true
      t.timestamps
    end

    add_index :users_programs_ratings, [:user_id, :program_id], unique: true
  end
end
