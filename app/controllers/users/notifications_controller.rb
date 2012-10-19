class Users::NotificationsController < ApplicationController
  authorize_resource :class => false

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    [:messages, :followers].each do |item|
      field = "notify_#{item}".to_sym
      @user[field] = params[:user][field]
    end

    @user.save

    respond_with @user, :location => edit_user_notifications_path
  end
end
