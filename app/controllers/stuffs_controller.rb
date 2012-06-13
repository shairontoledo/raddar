class StuffsController < ApplicationController
  load_and_authorize_resource :pub
  load_and_authorize_resource through: :pub, find_by: :slug


  # GET /stuffs/1
  # GET /stuffs/1.xml
  def show
    respond_with @stuff
  end

  # GET /stuffs/new
  # GET /stuffs/new.xml
  def new
    respond_with @stuff
  end

  # GET /stuffs/1/edit
  def edit
  end

  # POST /stuffs
  # POST /stuffs.xml
  def create
    current_user.watchings.create(watchable: @stuff) if @stuff.save
    respond_with @pub, @stuff
  end

  # PUT /stuffs/1
  # PUT /stuffs/1.xml
  def update
    @stuff.update_attributes(params[:stuff])
    respond_with @stuff.pub,@stuff
  end

  # DELETE /stuffs/1
  # DELETE /stuffs/1.xml
  def destroy
    @stuff.destroy
    respond_with @stuff, location: @stuff.pub
  end
end
