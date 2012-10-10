class Admin::NewslettersController < ApplicationController
  load_and_authorize_resource

  def index
    @newsletters = @newsletters.order_by([:created_at, :desc]).paginate(page: params[:page], per_page: 10)
    respond_with(@newsletters)
  end

  def show
    respond_with(@newsletter)
  end

  def new
    respond_with(@newsletter)
  end

  def edit
  end

  def create
    @newsletter.save
    respond_with(@newsletter, location: admin_newsletters_path)
  end

  def update
    @newsletter.update_attributes params[:newsletter]
    respond_with @newsletter, location: admin_newsletters_path
  end

  def destroy
    @newsletter.destroy
    respond_with(@newsletter, location: admin_newsletters_path)
  end
end
