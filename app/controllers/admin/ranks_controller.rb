class Admin::RanksController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /ranks
  # GET /ranks.xml
  def index
    @universe = Universe.find params[:universe_id]
    @ranks = @universe.ranks.order_by :level
    respond_with(@ranks)
  end

  # GET /ranks/new
  # GET /ranks/new.xml
  def new
    @universe = Universe.find params[:universe_id]
    @rank = @universe.ranks.new
    @rank.level = @universe.ranks.count + 1
    respond_with(@rank)
  end

  # GET /ranks/1/edit
  def edit
    @universe = Universe.find params[:universe_id]
    @rank = Rank.find(params[:id])
  end

  # POST /ranks
  # POST /ranks.xml
  def create
    @universe = Universe.find params[:universe_id]
    @rank = @universe.ranks.new(params[:rank])
    @rank.level = @universe.ranks.count + 1
    @rank.save
    respond_with @rank, location: admin_universe_ranks_path(@universe)
  end

  # PUT /ranks/1
  # PUT /ranks/1.xml
  def update
    @universe = Universe.find params[:universe_id]
    @rank = Rank.find(params[:id])
    @rank.update_attributes(params[:rank])
    respond_with @rank, location: admin_universe_ranks_path(@universe)
  end

  # DELETE /ranks/1
  # DELETE /ranks/1.xml
  def destroy
    @universe = Universe.find params[:universe_id]
    @rank = Rank.find(params[:id])
    @rank.destroy
    respond_with @rank, location: admin_universe_ranks_path(@universe)
  end
end
