class Users::PrivacyController < ApplicationController
  authorize_resource :class => false

  def edit
  	@user = current_user
    @user.accounts.each {|a| @user["#{a.provider}_privacy".to_sym] = a.url_privacy }
  end

  def update
    @user = current_user

    [:email,:date_of_birth,:gender,:location].each do |field|
      privacy_field = "#{field}_privacy".to_sym
      @user[privacy_field] = params[:user][privacy_field]
    end

    @user.accounts.each do |account|
      privacy_field = "#{account.provider}_privacy".to_sym
      account.url_privacy = params[:user][privacy_field] unless params[:user][privacy_field].nil?
      account.save!
    end

    @user.save

    respond_with @user, :location => edit_user_privacy_path
  end
end
