require 'will_paginate/array'

class ForumsController < ApplicationController
  load_and_authorize_resource
  # GET /forums
  # GET /forums.xml
  def index
    @forums = Forum.last_forums

    if params[:admin]
      render 'admin_index' 
    else
      respond_with(@forums)
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.last_topics.paginate(page: params[:page], per_page: 10)
    respond_with(@forum)
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new
    @forum = Forum.new
    respond_with(@forum)
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum = Forum.new(params[:forum])
    @forum.save
    respond_with(@forum)
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.find(params[:id])
    @forum.update_attributes(params[:forum])
    respond_with(@forum)
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy

    flash[:alert] = @forum.errors[:base].first if @forum.errors.any?

    respond_with(@forum, location: forums_path(admin: true))
  end
end
