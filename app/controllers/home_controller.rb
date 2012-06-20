require 'will_paginate/array'

class HomeController < ApplicationController
  authorize_resource :class => false
  
  def index
    @pubs = Pub.all.order_by [:created_at, :desc]
    @stuffs = Stuff.all.order_by [:created_at, :desc]
    @topics = Topic.all.order_by [:created_at, :desc]
    @venues = Venue.all.order_by [:created_at, :desc]
  end

  def search
    if params[:scope].blank?
      filters = {}
    else
      filters = {"only_for_#{params[:scope]}".to_sym => true}
    end

    @results = User.fulltext_search(params[:q], filters).paginate(page: params[:page], per_page: 10)
  end
end
