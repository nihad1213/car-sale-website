class ContactMailer < ApplicationMailer
  def new_message(contact_message)
    @contact_message = contact_message
    mail(
      to: ENV.fetch("CONTACT_RECIPIENT", "info@example.com"), # swap for your site config email
      reply_to: contact_message.email,
      subject: "[Contact] #{contact_message.subject}"
    )
  end
end
