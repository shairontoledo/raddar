require 'will_paginate/array'

class ForumsController < ApplicationController
  load_and_authorize_resource
  # GET /forums
  # GET /forums.xml
  def index
    @forums = @forums.order_by [:updated_at, :desc]

    @posts = Post.all.order_by [:created_at, :desc]

    respond_with @forums
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @topics = @forum.topics.order_by([:updated_at, :desc]).paginate(page: params[:page], per_page: 10)
    respond_with @forum
  end
end
