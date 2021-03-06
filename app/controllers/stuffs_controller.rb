class StuffsController < ApplicationController
  load_and_authorize_resource :pub
  load_and_authorize_resource through: :pub, find_by: :slug


  # GET /stuffs/1
  # GET /stuffs/1.xml
  def show
    @stuff.update_attribute(:views, @stuff.views+1)
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
    if @stuff.save
      current_user.watchings.create(watchable: @stuff) 
      @stuff.touch
    end

    respond_with @pub, @stuff
  end

  # PUT /stuffs/1
  # PUT /stuffs/1.xml
  def update
    if Pub.find(params[:stuff][:pub_id]).user == current_user
      @stuff.update_attributes(params[:stuff])
    end
    respond_with @stuff.pub,@stuff
  end

  # DELETE /stuffs/1
  # DELETE /stuffs/1.xml
  def destroy
    @stuff.destroy
    respond_with @stuff, location: @stuff.pub
  end
end
