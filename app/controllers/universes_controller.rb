class UniversesController < ApplicationController
  load_and_authorize_resource

  # GET /universes/1
  # GET /universes/1.xml
  def show
    respond_with @universe
  end
end
