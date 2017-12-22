class UserNotificationsMailer < ApplicationMailer
  default from: "correo@test.com"

  layout 'mailer'

  def sign_up_mailer(user)
    @user = user
    mail( to: @user.email, subject: "Welcome!" )
  end
  
end
