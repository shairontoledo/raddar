require 'will_paginate/array'

class Admin::ForumsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @forums = Forum.all.paginate(page: params[:page], per_page: 10)

    respond_with(@forums)
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
    respond_with @forum, location: admin_forums_path
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.find(params[:id])
    @forum.update_attributes(params[:forum])
    respond_with @forum, location: admin_forums_path
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy

    flash[:alert] = @forum.errors[:base].first if @forum.errors.any?

    respond_with @forum, location: admin_forums_path
  end
end
