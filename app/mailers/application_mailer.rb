class ApplicationMailer < ActionMailer::Base
  default from: Zendogs::CONTACT_EMAIL
  layout 'mailer'
end
