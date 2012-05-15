class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = User.where(name: params[:name]).first


    respond_with @user

  end
end
