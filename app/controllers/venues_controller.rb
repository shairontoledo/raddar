class VenuesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:index, :nearby]
  # GET /venues
  # GET /venues.xml
  def index
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show
    respond_with @venue
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    respond_with @venue
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue.coordinates = [params[:lng].to_f, params[:lat].to_f]
    @venue.user = current_user
    @venue.save
    respond_with @venue
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
      @venues = Venue.near(@coordinates, 10).limit(10)
    else
      @venues = []
    end
  end
end
