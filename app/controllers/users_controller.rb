class UsersController < ApplicationController
  load_and_authorize_resource
  
  def show
    @user = User.where(name: params[:name]).first
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user#User.where(name: params[:id]).first
  end

end
