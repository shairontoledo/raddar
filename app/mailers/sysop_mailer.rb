class SysopMailer < ActionMailer::Base
  helper :application
  default from: "from@example.com"

  def contact_email contact
    
    @contact = contact

    send_mail I18n.t('sysop_mailer.subject.contact', name: @contact.name)
  end

  private
  def send_mail subject
    title = Raddar::config.app['name']

    mail to: "Sysop <#{Raddar::config.sysop['email']}>", subject: "#{title} - #{subject}"
  end
end
