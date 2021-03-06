require 'will_paginate/array'

class Admin::NewslettersController < ApplicationController
  load_and_authorize_resource

  def index
    @newsletters = @newsletters.order_by([:created_at, :desc]).paginate(page: params[:page], per_page: 10)
    respond_with(@newsletters)
  end

  def new
    respond_with(@newsletter)
  end

  def edit
  end

  def send_now
    @newsletter.sent_at = Time.now
    @newsletter.save!
    Delayed::Job.enqueue SendNewsletterJob.new(@newsletter.id)
    respond_with @newsletter, location: admin_newsletters_path
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
