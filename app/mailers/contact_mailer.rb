class ContactMailer < ApplicationMailer
  def new_message(contact_message)
    @contact_message = contact_message
    mail(
      to: Rails.application.credentials.dig(:contact, :recipient),
      reply_to: contact_message.email,
      subject: "[Contact] #{contact_message.subject}"
    )
  end
end
