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
end
