class Notifications::EndCooperationWithCoachWorker < Notifications::Notification
  def perform(args)
    Notifications::EndCooperationWithCoachService.new(
      user_id: args['user_id'],
      coach_id: args['coach_id']
    ).perform
  end
end