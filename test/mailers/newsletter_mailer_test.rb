require "test_helper"

class NewsletterMailerTest < ActionMailer::TestCase
  test "newsletter" do
    mail = NewsletterMailer.newsletter
    assert_equal "Newsletter", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
