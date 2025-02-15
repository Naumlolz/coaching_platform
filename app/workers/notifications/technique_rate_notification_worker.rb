class Notifications::TechniqueRateNotificationWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(user_id, technique_id, rate)
    user = User.find(user_id)
    technique = Technique.find(technique_id)

    Notifications::TechniqueRateNotificationService.new(
      user: user,
      technique_id: technique_id,
      rate: rate
    ).perform
  end
end