require 'will_paginate/array'

class Forums::TopicsController < ApplicationController
  load_and_authorize_resource 


  # GET /forums_topics/1
  # GET /forums_topics/1.xml
  def show
    @topic = Topic.find(params[:id])

    per_page = 10

    if(params[:page].blank? && (!params[:post_id].blank?))
      search_post = Post.find(params[:post_id])
      @topic.first_posts.each_with_index do |p,i|
        params[:page] = ((i/per_page)+1) if ((i > per_page) && (p == search_post))
      end
    end

    @posts = @topic.first_posts.paginate(page: params[:page], per_page: per_page)
    @topic.update_attribute(:views, @topic.views+1)
    @post = @topic.posts.new
    @post[:watch] = true
    respond_with(@topic)
  end

  # GET /forums_topics/new
  # GET /forums_topics/new.xml
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new
    @post = @topic.posts.new
    @post[:watch] = true
    respond_with(@topic)
  end

  # GET /forums_topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /forums_topics
  # POST /forums_topics.xml
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new(params[:topic])
    @topic.user = current_user
    
    @post = @topic.posts.new(params[:topic][:post])
    @post.user = current_user

    @topic.valid?

    if @post.valid? && @topic.valid?
      @post.save
      @topic.save
      @topic.watchers << current_user if params[:topic][:post][:watch] == '1'
    else
      @topic.add_error(:base,:content_required)
    end

    respond_with(@forum, @topic)
  end

  # PUT /forums_topics/1
  # PUT /forums_topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes(params[:topic])
    respond_with(@topic.forum, @topic)
  end

  # DELETE /forums_topics/1
  # DELETE /forums_topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_with(@topic, location: @topic.forum)
  end

  def unwatch
    @topic = Topic.find(params[:id])

    @topic.watcher_ids.delete(current_user.id)
    @topic.save

    redirect_to(forum_topic_path(@topic), notice: t('flash.topic.unwatched'))

  end
end
