class UsersController < ApplicationController
  load_and_authorize_resource
  
  def show
    @user = User.where(name: params[:name]).first

    respond_with @user
  end

  def index
    @users = User.all

    respond_with @users
  end

  def edit
    @user = User.where(name: params[:name]).first

    respond_with @user
  end

  def update 
    @user = User.where(name: params[:name]).first
    @user.roles.clear
    
    params[:user][:role_ids].each do |id|
      @user.roles << Role.find(id) unless id.blank?
    end

    respond_with @user, location: users_path
  end
end
