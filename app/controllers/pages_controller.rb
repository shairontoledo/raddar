class PagesController < ApplicationController
  load_and_authorize_resource
  
  # GET /pages/1
  # GET /pages/1.xml
  def show
    respond_with @page
  end

end
