class RemoveBodyFromUsersCoachesInvitations < ActiveRecord::Migration[6.1]
  def change
    remove_column :users_coaches_invitations, :body, :string
  end
end
