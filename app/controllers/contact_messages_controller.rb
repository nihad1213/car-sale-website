class ContactMessagesController < ApplicationController
  rate_limit to: 5, within: 10.minutes, only: :create, with: -> {
    @contact_message = ContactMessage.new
    @contact_message.errors.add(:base, "Too many messages sent. Please try again in a few minutes.")
    render "contact_messages/form", status: :too_many_requests
  }

  def create
    return render("contact_messages/success") if params[:website].present?

    @contact_message = ContactMessage.new(contact_message_params)

    if @contact_message.save
      ContactMailer.new_message(@contact_message).deliver_later
      render "contact_messages/success"
    else
      render "contact_messages/form", status: :unprocessable_entity
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :subject, :message)
  end
end
