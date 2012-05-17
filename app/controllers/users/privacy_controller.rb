class Users::PrivacyController < ApplicationController
  before_filter :authenticate_user!

  def edit
  	@user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    [:gender,:date_of_birth,:email,:facebook_url].each do |field|
      privacy_field = "#{field}_privacy".to_sym
      @user[privacy_field] = params[:user][privacy_field]
    end

    if @user.save
      flash[:notice] = t('flash.privacy.updated')
    else
      flash[:alert] = t('flash.privacy.error')
    end

    respond_with @user, :location => edit_user_privacy_path
  end
end
