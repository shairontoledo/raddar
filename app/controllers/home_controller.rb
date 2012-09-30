require 'will_paginate/array'

class HomeController < ApplicationController
  authorize_resource :class => false
  
  def index
    @top_read = Stuff.all.order_by [:views, :desc]
    @top_discussed = Topic.all.sort_by {|t| t.posts.count }.reverse
    @best = Stuff.all.sort_by {|s| s.votes.where(value: :like).count }.reverse
    @topics = Topic.all.order_by [:created_at, :desc]
    @tags = Tag.all.sort_by {|t| t.taggings.count }.reverse
    @comments = Comment.all.order_by [:created_at, :desc]
    @universes = Universe.all.order_by [:name, :asc]
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
