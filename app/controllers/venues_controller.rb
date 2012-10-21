class VenuesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:index, :nearby]

  def index
  end

  def show
    respond_with @venue
  end

  def new
    @venue.coordinates = [params[:lng].to_f, params[:lat].to_f]
    respond_with @venue
  end

  def create
    @venue.coordinates = [params[:lng].to_f, params[:lat].to_f]
    @venue.user = current_user
    if @venue.save
      current_user.watchings.create(watchable: @venue) 
    end

    flash[:alert] = @venue.errors[:base].first if @venue.errors.any? && (!@venue.errors[:base].empty?)

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
      begin
        @venues = Venue.near(@coordinates, 10).limit(10).to_a
      rescue
        @venues = []
      end

    else
      @venues = []
    end

    @venues = Venue.order_by([:created_at, :desc]) if @venues.empty?
  end
end
