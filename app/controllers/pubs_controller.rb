class PubsController < ApplicationController
  load_and_authorize_resource
  # GET /pubs
  # GET /pubs.xml
  def index
    respond_with @pubs
  end

  # GET /pubs/1
  # GET /pubs/1.xml
  def show
    @stuffs = @pub.stuffs.order_by([:created_at, :desc]).paginate(page: params[:page], per_page: 10)

    respond_with @pub
  end

  # GET /pubs/new
  # GET /pubs/new.xml
  def new
    respond_with @pub
  end

  # GET /pubs/1/edit
  def edit

  end

  # POST /pubs
  # POST /pubs.xml
  def create
    @pub.user = current_user
    @pub.save
    respond_with @pub
  end

  # PUT /pubs/1
  # PUT /pubs/1.xml
  def update
    @pub.update_attributes(params[:pub])
    respond_with @pub
  end

  # DELETE /pubs/1
  # DELETE /pubs/1.xml
  def destroy
    @pub.destroy
    respond_with @pub
  end
end
