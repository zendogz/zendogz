class ContactMailer < ApplicationMailer
  def contact_message(user)
    @user = user
    mail(to: Zendogs::CONTACT_EMAIL, subject: 'Welcome to My Awesome Site')
  end
end
