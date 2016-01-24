class ContactMailer < ApplicationMailer
  def contact_message(message, from)
    @message = message
    @from = from || 'anonymous'
    mail(from: from || Zendogs::CONTACT_EMAIL, to: Zendogs::CONTACT_EMAIL, subject: 'zendogz contact form message')
  end
end
