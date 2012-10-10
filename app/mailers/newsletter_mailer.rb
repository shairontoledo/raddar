class NewsletterMailer < ActionMailer::Base
  helper :application
  layout 'mailer'
  default from: Raddar::config.email['from']

  def newsletter_mail newsletter, user
    @newsletter = newsletter

    send_mail user, @newsletter.subject
  end

  private
  def send_mail user, subject
    mail to: "#{user.name} <#{user.email}>", subject: subject
  end
end
