class Admin::RanksController < ApplicationController
  load_and_authorize_resource :universe
  load_and_authorize_resource through: :universe
  # GET /ranks
  # GET /ranks.xml
  def index
    @ranks = @ranks.order_by [:level, :asc]
    respond_with @ranks
  end

  # GET /ranks/new
  # GET /ranks/new.xml
  def new
    @rank.level = @universe.ranks.count + 1
    respond_with @rank
  end

  # GET /ranks/1/edit
  def edit
  end

  # POST /ranks
  # POST /ranks.xml
  def create
    @rank.level = @universe.ranks.count + 1
    @rank.save
    respond_with @rank, location: admin_universe_ranks_path(@universe)
  end

  # PUT /ranks/1
  # PUT /ranks/1.xml
  def update
    @rank.update_attributes params[:rank]
    respond_with @rank, location: admin_universe_ranks_path(@universe)
  end

  # DELETE /ranks/1
  # DELETE /ranks/1.xml
  def destroy
    @rank.destroy
    respond_with @rank, location: admin_universe_ranks_path(@universe)
  end
end
