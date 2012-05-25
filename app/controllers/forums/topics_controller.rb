class Forums::TopicsController < ApplicationController
  load_and_authorize_resource


  # GET /forums_topics/1
  # GET /forums_topics/1.xml
  def show
    @topic = Forums::Topic.find(params[:id])
    respond_with(@topic)
  end

  # GET /forums_topics/new
  # GET /forums_topics/new.xml
  def new
    @topic = Forums::Topic.new
    respond_with(@topic)
  end

  # GET /forums_topics/1/edit
  def edit
    @topic = Forums::Topic.find(params[:id])
  end

  # POST /forums_topics
  # POST /forums_topics.xml
  def create
    @topic = Forums::Topic.new(params[:topic])
    @forums_topic.save
    respond_with(@topic)
  end

  # PUT /forums_topics/1
  # PUT /forums_topics/1.xml
  def update
    @topic = Forums::Topic.find(params[:id])
    @forums_topic.update_attributes(params[:topic])
    respond_with(@topic)
  end

  # DELETE /forums_topics/1
  # DELETE /forums_topics/1.xml
  def destroy
    @topic = Forums::Topic.find(params[:id])
    @forums_topic.destroy
    respond_with(@topic)
  end
end
