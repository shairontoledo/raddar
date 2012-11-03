require 'will_paginate/array'

class HomeController < ApplicationController
  skip_authorization_check

  caches_action :index, layout: false, expires_in: 5.minutes
  
  def index
    @top_read = Stuff.all.order_by [:views, :desc]
    @top_discussed = Topic.all.sort_by {|t| t.posts.count }.reverse
    @best = Stuff.all.sort_by {|s| s.votes.where(value: :like).count }.reverse
    @topics = Topic.all.order_by [:created_at, :desc]
    @tags = Tag.all.sort_by {|t| t.taggings.count }.reverse
    @comments = Comment.all.order_by [:created_at, :desc]
    @universes = Universe.all.order_by [:name, :asc]
    @last_users = User.where(:confirmed_at.exists => true).order_by([:created_at, :desc])
  end

  def search
    filters = {max_results: 1_000_000}

    filters["only_for_#{params[:scope]}".to_sym] = true unless params[:scope].blank?

    @results = User.fulltext_search(params[:q], filters).paginate(page: params[:page], per_page: 10)
  end

  def exception
    @type = env["PATH_INFO"][1..-1]
  end
end
