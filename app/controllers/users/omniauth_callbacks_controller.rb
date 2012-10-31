class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    perform request.env["omniauth.auth"]
  end

  def twitter
    perform request.env["omniauth.auth"].except('extra')
  end

  def passthru
    redirect_to not_found_error_path, status: 404
  end

  private
  def perform access_data
    acc = Account.find_for_oauth(access_data, current_user)
    @user = acc.user
    provider_name = access_data.provider.titleize

    if user_signed_in?
      if current_user.save && !current_user.accounts.where(provider: acc.provider).empty?
        flash[:notice] = t 'flash.users.accounts.add.notice', provider: provider_name
      else
        flash[:alert] = t 'flash.users.accounts.add.alert', provider: provider_name
      end
      redirect_to user_accounts_path
    else
      if @user.persisted?
        flash[:notice] = t "devise.omniauth_callbacks.success", kind: provider_name
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.oauth_temp_data"] = access_data
        redirect_to new_user_registration_url
      end
    end
  end
end