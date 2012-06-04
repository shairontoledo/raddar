class Admin::VenuesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /venues
  # GET /venues.xml
  def index
    @venues = Venue.all.paginate(page: params[:page], per_page: 10)
    respond_with(@venues)
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue = Venue.find(params[:id])
    @venue.update_attributes(params[:venue])
    @venue.coordinates = [params[:lng].to_f, params[:lat].to_f]
    @venue.save
    respond_with(@venue)
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
    respond_with(@venue)
  end
end
