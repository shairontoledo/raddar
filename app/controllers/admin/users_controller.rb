class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all.paginate(page: params[:page], per_page: 10)

    respond_with @users
  end

  def edit
    @user = User.find(params[:id])

    respond_with @user
  end

  def update 
    @user = User.find(params[:id])

    @user.status = params[:user][:status]


    @user.roles.clear
    
    params[:user][:role_ids].each do |id|
      @user.roles << Role.find(id) unless id.blank?
    end

    @user.save

    respond_with @user, location: admin_users_path
  end
end