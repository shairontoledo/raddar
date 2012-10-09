class SysopMailer < ActionMailer::Base
  helper :application
  layout 'mailer'
  default from: Raddar::config.email['from']

  def contact_email contact
    
    @contact = contact

    send_mail I18n.t('sysop_mailer.subject.contact', name: @contact.name)
  end

  private
  def send_mail subject
    mail to: "Sysop <#{Raddar::config.sysop['email']}>", subject: subject
  end
end
