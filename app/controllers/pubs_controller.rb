class PubsController < ApplicationController
  load_and_authorize_resource
  # GET /pubs
  # GET /pubs.xml
  def index
    @pubs = Pub.all
    respond_with(@pubs)
  end

  # GET /pubs/1
  # GET /pubs/1.xml
  def show
    @pub = Pub.find(params[:id])
    respond_with(@pub)
  end

  # GET /pubs/new
  # GET /pubs/new.xml
  def new
    @pub = current_user.pubs.new
    respond_with(@pub)
  end

  # GET /pubs/1/edit
  def edit
    @pub = Pub.find(params[:id])
  end

  # POST /pubs
  # POST /pubs.xml
  def create
    @pub = current_user.pubs.new(params[:pub])
    @pub.save
    respond_with(@pub)
  end

  # PUT /pubs/1
  # PUT /pubs/1.xml
  def update
    @pub = Pub.find(params[:id])
    @pub.update_attributes(params[:pub])
    respond_with(@pub)
  end

  # DELETE /pubs/1
  # DELETE /pubs/1.xml
  def destroy
    @pub = Pub.find(params[:id])
    @pub.destroy
    respond_with(@pub)
  end
end
