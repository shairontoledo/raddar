require 'will_paginate/array'

class Admin::ForumsController < ApplicationController
  load_and_authorize_resource

  def index
    @forums = @forums.paginate(page: params[:page], per_page: 10)

    respond_with @forums
  end

    # GET /forums/new
  # GET /forums/new.xml
  def new
    respond_with @forum
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum.save
    respond_with @forum, location: admin_forums_path
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum.update_attributes params[:forum]
    respond_with @forum, location: admin_forums_path
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum.destroy

    flash[:alert] = @forum.errors[:base].first if @forum.errors.any?

    respond_with @forum, location: admin_forums_path
  end
end
