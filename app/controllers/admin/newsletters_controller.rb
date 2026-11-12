class Admin::NewslettersController < ApplicationController
  before_action :require_admin!

  def new
  end

  def create
    subject = newsletter_params[:subject]
    message = newsletter_params[:message]

    if subject.blank? || message.blank?
      flash.now[:alert] = "Subject and message are required."
      render :new, status: :unprocessable_entity
      return
    end

    Subscriber.find_each do |subscriber|
      NewsletterMailer.with(
        email: subscriber.email,
        subject: subject,
        message: message
      ).newsletter.deliver_now
    end

    redirect_to admin_subscribers_path,
                notice: "Newsletter sent successfully!"
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:subject, :message)
  end
end
