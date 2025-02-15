class Notifications::Notification
  include Sidekiq::Worker

  sidekiq_options retry: false
end
