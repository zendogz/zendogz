class PersonMailer < ApplicationMailer
  def new_person_message(person)
    @password = person.password
    mail(from: Zendogs::CONTACT_EMAIL, to: person.email, subject: 'zendogz user created')
  end
end
