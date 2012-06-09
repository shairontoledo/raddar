class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def show
    @user = User.find params[:id]

    respond_with @user
  end

  # Following
  def following
    @user = User.find params[:id]

    @followerships = @user.followerships.paginate(page: params[:page], per_page: 9)
  end
end
