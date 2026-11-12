# Preview all emails at http://localhost:3000/rails/mailers/newsletter_mailer
class NewsletterMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/newsletter_mailer/newsletter
  def newsletter
    NewsletterMailer.newsletter
  end
end
