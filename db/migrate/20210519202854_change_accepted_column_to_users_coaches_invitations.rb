class ChangeAcceptedColumnToUsersCoachesInvitations < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users_coaches_invitations, :accepted, from: false, to: nil
  end
end
