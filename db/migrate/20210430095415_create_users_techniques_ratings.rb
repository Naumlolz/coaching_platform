class CreateUsersTechniquesRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :users_techniques_ratings do |t|
      t.string :rate
      t.belongs_to :user, foreign_key: true
      t.belongs_to :technique, foreign_key: true
      t.timestamps
    end
  end
end
