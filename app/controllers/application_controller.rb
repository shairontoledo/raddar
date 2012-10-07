require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :atom
  helper_method :raddar_path

  check_authorization :unless => :devise_controller?

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
  	if user_signed_in?
      redirect_to root_url, alert: exception.message
    else
      authenticate_user!
    end
  end

  def default_url_options options={}
    {host: 'abc.com'}
  end

  def raddar_path resource, options={}
    send "#{resource.class.name.underscore}_path".to_sym, resource, options
  end
end
