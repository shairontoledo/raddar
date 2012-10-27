require 'will_paginate/array'


class Users::FolloweesController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :followership, through: :user, parent: false

  def index
    @followerships = @followerships.order_by([:created_at, :desc]).paginate page: params[:page], per_page: 60
  end
end
