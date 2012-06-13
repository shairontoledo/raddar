require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  check_authorization :unless => :devise_controller?

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
  	if user_signed_in?
      redirect_to root_url, alert: exception.message
    else
      authenticate_user!
    end
  end
end
