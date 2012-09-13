class Users::FolloweesController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :followership, through: :user, parent: false

  def index
    @followerships = @followerships.paginate page: params[:page], per_page: 30
  end
end
