class PagesController < ApplicationController
  load_and_authorize_resource
  
  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])
    respond_with(@page)
  end

end
