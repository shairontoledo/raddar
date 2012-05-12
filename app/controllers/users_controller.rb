class UsersController < ApplicationController
  def show
    @user = User.where(name: params[:name]).first


    respond_with @user

  end
end
