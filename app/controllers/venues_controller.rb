class VenuesController < ApplicationController
  load_and_authorize_resource
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
    @venue.coordinates = [params[:lng].to_f, params[:lat].to_f]
    @venue.author = current_user
    @venue.save
    respond_with(@venue)
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

  def nearby
    if !params[:lat].blank? && !params[:lng].blank?
      @coordinates = [params[:lat].to_f, params[:lng].to_f]
      @term = params[:term].strip

    elsif !params[:term].blank?
      @coordinates = Geocoder::coordinates params[:term]
      @term = params[:term].strip
    else
      @coordinates = request.location.coordinates
      @term = request.location.address
    end

    unless @coordinates.blank?
      @venues = Venue.near @coordinates, 20
    else
      @venues = []
    end
    #@venues.limit 20
  end
end
