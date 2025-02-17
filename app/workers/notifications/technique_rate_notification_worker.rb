class Notifications::TechniqueRateNotificationWorker < Notifications::Notification
  def perform(args)
    user = User.find(args['user_id'])

    Notifications::TechniqueRateNotificationService.new(
      user: user,
      technique_id: args['technique_id'],
      rate: args['rate']
    ).perform
  end
end
