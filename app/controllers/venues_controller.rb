class VenuesController < ApplicationController
  # GET /venues
  # GET /venues.xml
  def index
    @venues = Venue.all
    respond_with(@venues)
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show
    @venue = Venue.find(params[:id])
    respond_with(@venue)
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = Venue.new
    respond_with(@venue)
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue = Venue.new(params[:venue])
    @venue.save
    respond_with(@venue)
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue = Venue.find(params[:id])
    @venue.update_attributes(params[:venue])
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
