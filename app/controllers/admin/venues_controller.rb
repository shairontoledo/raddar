class Admin::VenuesController < ApplicationController
  load_and_authorize_resource
  # GET /venues
  # GET /venues.xml
  def index
    @venues = @venues.order_by([:name, :asc]).paginate(page: params[:page], per_page: 10)
    respond_with @venues
  end

  # GET /venues/1/edit
  def edit
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue.update_attributes params[:venue]
    @venue.coordinates = [params[:lng].to_f, params[:lat].to_f]
    @venue.save
    respond_with @venue, location: admin_venues_path
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    @venue.destroy
    respond_with @venue, location: admin_venues_path
  end
end
