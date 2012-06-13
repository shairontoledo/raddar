class Admin::PagesController < ApplicationController
  load_and_authorize_resource
  # GET /pages
  # GET /pages.xml
  def index
    @pages = @pages.paginate(page: params[:page], per_page: 10)
    respond_with @pages
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    respond_with @page
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page.save
    respond_with @page, location: admin_pages_path
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page.update_attributes params[:page]
    respond_with @page, location: admin_pages_path
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page.destroy
    respond_with @page, location: admin_pages_path
  end
end