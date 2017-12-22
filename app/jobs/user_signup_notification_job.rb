class UserSignupNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    if user
      UserNotificationsMailer.sign_up_mailer(user)
    end    
  end
end
