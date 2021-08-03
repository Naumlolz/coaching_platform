class CreateCoachesPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches_programs do |t|
      t.belongs_to :coach, foreign_key: true
      t.belongs_to :program, foreign_key: true
      t.timestamps
    end
  end
end
