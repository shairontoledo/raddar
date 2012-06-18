class ContactsController < ApplicationController
  load_and_authorize_resource

  def new
    respond_with @contact
  end

  def create
    if user_signed_in?
      @contact.name = current_user.name
      @contact.email = current_user.email
      @contact.user = current_user
      @contact.save
    else
      if Raddar::config.recaptcha['enabled']
        @contact.save if verify_recaptcha model: @contact, attribute: :captcha
        flash.delete :recaptcha_error
      else
        @contact.save
      end 
    end

    SysopMailer.delay(queue: 'contact_email').contact_email(@contact) if @contact.persisted?

    respond_with @contact, location: root_path
  end
end
