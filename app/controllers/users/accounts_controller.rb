class Users::AccountsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def destroy
    @account.destroy
    respond_with @account, location: user_accounts_path
  end
end
