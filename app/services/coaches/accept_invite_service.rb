# trainer invitation acceptance logic handler
class Coaches::AcceptInviteService
  def initialize(params)
    @coach_id = params[:coach_id]
    @invite_id = params[:invite_id]
  end

  def call
    find_invitation
    update_invitation
    assign_coach_to_user
    increment_total_users
  end

  private

  attr_reader :coach_id, :invite_id

  def find_invitation
    @found_invite = UsersCoachesInvitation.find_by(id: invite_id)
  end

  def update_invitation
    find_invitation.update(accepted: true)
    raise ServiceError, 'You can`t accept invite' if find_invitation.invalid?
  end

  def assign_coach_to_user
    assign_status = find_invitation.user.update(coach_id: coach_id)
    raise ServiceError, 'You cannot assign user' unless assign_status
  end

  def increment_total_users
    Coach.find(coach_id).increment_total_users!
  end
end
