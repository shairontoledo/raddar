class Admin::HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, User
  end
end
