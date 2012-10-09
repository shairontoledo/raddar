require 'will_paginate/array'

class Admin::UniversesController < ApplicationController
  load_and_authorize_resource
  # GET /universes
  # GET /universes.xml
  def index
    @universes = @universes.order_by([:name, :asc]).paginate(page: params[:page], per_page: 10)
    respond_with @universes
  end

  # GET /universes/new
  # GET /universes/new.xml
  def new
    respond_with @universe
  end

  # GET /universes/1/edit
  def edit
  end

  # POST /universes
  # POST /universes.xml
  def create
    @universe.save
    respond_with @universe, location: admin_universes_path
  end

  # PUT /universes/1
  # PUT /universes/1.xml
  def update
    @universe.update_attributes params[:universe]
    respond_with @universe, location: admin_universes_path
  end

  # DELETE /universes/1
  # DELETE /universes/1.xml
  def destroy
    @universe.destroy
    respond_with @universe, location: admin_universes_path
  end
end
