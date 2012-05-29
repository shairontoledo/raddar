class StuffsController < ApplicationController
  load_and_authorize_resource


  # GET /stuffs/1
  # GET /stuffs/1.xml
  def show
    @stuff = Stuff.find(params[:id])
    respond_with(@stuff)
  end

  # GET /stuffs/new
  # GET /stuffs/new.xml
  def new
    @pub = Pub.find(params[:pub_id])
    @stuff = @pub.stuffs.new

    respond_with(@stuff)
  end

  # GET /stuffs/1/edit
  def edit
    @stuff = Stuff.find(params[:id])
  end

  # POST /stuffs
  # POST /stuffs.xml
  def create
    @pub = Pub.find(params[:pub_id])
    @stuff = @pub.stuffs.new(params[:stuff])
    current_user.watchings.create(watchable: @stuff) if @stuff.save
    respond_with(@pub, @stuff)
  end

  # PUT /stuffs/1
  # PUT /stuffs/1.xml
  def update
    @stuff = Stuff.find(params[:id])
    @stuff.update_attributes(params[:stuff])
    respond_with(@stuff.pub,@stuff)
  end

  # DELETE /stuffs/1
  # DELETE /stuffs/1.xml
  def destroy
    @stuff = Stuff.find(params[:id])
    @stuff.destroy
    respond_with(@stuff, location: @stuff.pub)
  end
end
