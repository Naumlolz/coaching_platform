class Coaches::AcceptInviteService
  def initialize(coach_id, invite_id)
    @coach_id = coach_id
    @invite_id = invite_id
  end

  def call
    find_invitation
    update_invitation
    assign_coach_to_user
  end

  private

  def find_invitation
    @found_invite = UsersCoachesInvitation.find_by(id: @invite_id)
  end

  def update_invitation
    @found_invite.update(accepted: true)
    raise ServiceError, 'You can`t accept invite' if @found_invite.invalid?
  end

  def assign_coach_to_user
    assign_status = @found_invite.user.update(coach_id: @coach_id)
    raise ServiceError, 'You cannot assign user' unless assign_status
  end
end
