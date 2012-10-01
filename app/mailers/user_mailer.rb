class UserMailer < Devise::Mailer
  helper :application
  layout 'mailer'
  default from: Raddar::config.email['from']
end
