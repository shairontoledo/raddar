class Admin::HomeController < ApplicationController
  authorize_resource :class => false 

  def index
    authorize! :index, User
  end
end
