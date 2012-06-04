class Admin::UniversesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /universes
  # GET /universes.xml
  def index
    @universes = Universe.all.paginate(page: params[:page], per_page: 10)
    respond_with(@universes)
  end

  # GET /universes/new
  # GET /universes/new.xml
  def new
    @universe = Universe.new
    respond_with(@universe)
  end

  # GET /universes/1/edit
  def edit
    @universe = Universe.find(params[:id])
  end

  # POST /universes
  # POST /universes.xml
  def create
    @universe = Universe.new(params[:universe])
    @universe.save
    respond_with @universe, location: admin_universes_path
  end

  # PUT /universes/1
  # PUT /universes/1.xml
  def update
    @universe = Universe.find(params[:id])
    @universe.update_attributes(params[:universe])
    respond_with @universe, location: admin_universes_path
  end

  # DELETE /universes/1
  # DELETE /universes/1.xml
  def destroy
    @universe = Universe.find(params[:id])
    @universe.destroy
    respond_with @universe, location: admin_universes_path
  end
end
