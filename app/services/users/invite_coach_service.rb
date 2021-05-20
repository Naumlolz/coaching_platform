class Users::InviteCoachService
  def initialize(user, coach_id)
    @user = user
    @coach_id = coach_id
  end

  def call
    check_if_have_coach
    check_coach_counter
    create_invitation
  end

  private

  def check_if_have_coach
    if @user.coach_id.present?
      raise ServiceError, "You already have coach"
    end
  end

  def check_coach_counter
    invites_count = UsersCoachesInvitation.where(
      user_id: @user.id,
      accepted: nil
    ).count
    raise ServiceError, "You can`t invite more than 1 coach" if invites_count >= 1
  end

  def create_invitation
    invite = UsersCoachesInvitation.create(
      user_id: @user.id, 
      coach_id: @coach_id
    )
    raise ServiceError, "Could not invite" if invite.invalid?
  end
end
