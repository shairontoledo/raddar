class Admin::PubsController < ApplicationController
  load_and_authorize_resource
  # GET /pubs
  # GET /pubs.xml
  def index
    @pubs = @pubs.order_by([:name, :asc]).paginate(page: params[:page], per_page: 10)
    respond_with @pubs
  end

  def set_main
    @pub.main = true
    @pub.save
    respond_with @pub, location: admin_pubs_path
  end

  def remove_main
    @pub.main = false
    @pub.save
    respond_with @pub, location: admin_pubs_path
  end

  # DELETE /pubs/1
  # DELETE /pubs/1.xml
  def destroy
    @pub.destroy
    respond_with @pub, location: admin_pubs_path
  end
end
