class Users::AccountsController < ApplicationController
  authorize_resource :class => false

  def index
  end

  def destroy
    provider = params[:id].to_sym

    case provider
    when :facebook
      current_user.facebook_access_token = nil
      current_user.facebook_url = nil  
    end

    if current_user.save
      flash[:notice] = t 'flash.accounts.destroy.success', provider: provider.to_s.humanize
    else
      flash[:alert] = t 'flash.accounts.destroy.error', provider: provider.to_s.humanize
    end

    redirect_to user_accounts_path
  end
end
