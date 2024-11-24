class Users::InviteCoachService
  def initialize(params)
    @user = params[:user]
    @coach_id = params[:coach_id]
  end

  def call
    check_coach_present
    check_coach_counter
    create_invitation
    invitation_validation
  end

  private

  attr_reader :user, :coach_id

  def check_coach_present
    raise ServiceError, 'Could not invite' if coach_id.nil?
    raise ServiceError, 'You already have coach' if user.coach_id.present?
  end

  def check_coach_counter
    invites_count = UsersCoachesInvitation.where(
      user_id: user.id,
      accepted: nil
    ).count
    raise ServiceError, 'You cant invite more than 1 coach' if invites_count >= 1
  end

  def create_invitation
    @invite = UsersCoachesInvitation.create(
      user_id: user.id,
      coach_id: coach_id
    )
  end

  def invitation_validation
    raise ServiceError, 'Could not invite' if @invite.invalid?
  end
end
