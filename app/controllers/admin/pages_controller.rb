class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all.paginate(page: params[:page], per_page: 10)
    respond_with(@pages)
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new
    respond_with(@page)
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    @page.save
    respond_with @page, location: admin_pages_path
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])
    respond_with @page, location: admin_pages_path
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_with @page, location: admin_pages_path
  end
end