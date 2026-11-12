class NewsletterMailer < ApplicationMailer
  def newsletter
    @message = params[:message]

    mail(
      to: params[:email],
      subject: params[:subject]
    )
  end
end
