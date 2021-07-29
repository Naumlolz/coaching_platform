class CreateUsersCoachesInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :users_coaches_invitations do |t|
      t.string :body, null: false
      t.boolean :accepted, default: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :coach, foreign_key: true
      t.timestamps
    end
  end
end
