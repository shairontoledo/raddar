require 'pp'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    provider = 'Facebook'

    if user_signed_in?
      if current_user.save
        flash[:notice] = t 'flash.accounts.add.success', provider: provider
      else
        flash[:alert] = t 'flash.accounts.add.error', provider: provider
      end
      redirect_to user_accounts_path
    else
      if @user.persisted?
        flash[:notice] = t "devise.omniauth_callbacks.success", kind: provider
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end

  def twitter
    pp request.env['omniauth.auth']
  end


  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    # raise ActionController::RoutingError.new('Not Found')
  end
end