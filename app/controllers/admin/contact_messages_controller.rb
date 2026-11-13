class Admin::ContactMessagesController < ApplicationController
  before_action :require_admin!
  before_action :set_contact_message, only: %i[show destroy]

  def index
    @contact_messages = ContactMessage.latest
  end

  def show
    @contact_message.mark_as_read!
  end

  def destroy
    @contact_message.destroy
    redirect_to admin_contact_messages_path, notice: "Message was successfully deleted."
  end

  private

  def set_contact_message
    @contact_message = ContactMessage.find(params[:id])
  end
end
