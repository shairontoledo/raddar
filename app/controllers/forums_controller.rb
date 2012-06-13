require 'will_paginate/array'

class ForumsController < ApplicationController
  load_and_authorize_resource
  # GET /forums
  # GET /forums.xml
  def index
    @forums = @forums.order_by [:name, :asc]

    respond_with @forums
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @topics = @forum.last_topics.paginate(page: params[:page], per_page: 10)
    respond_with @forum
  end
end
