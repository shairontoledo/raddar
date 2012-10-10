class NewslettersController < ApplicationController
  load_and_authorize_resource
  
  def show
    respond_with @newsletter, layout: 'mailer', template: 'newsletter_mailer/newsletter_mail'
  end

end
