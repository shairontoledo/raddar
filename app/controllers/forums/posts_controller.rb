class Forums::PostsController < ApplicationController
  load_and_authorize_resource

  # POST /forums_posts
  # POST /forums_posts.xml
  def create
    @post = Forums::Post.new(params[:post])
    @forums_post.save
    respond_with(@post)
  end

  # PUT /forums_posts/1
  # PUT /forums_posts/1.xml
  def update
    @post = Forums::Post.find(params[:id])
    @forums_post.update_attributes(params[:post])
    respond_with(@post)
  end

  # DELETE /forums_posts/1
  # DELETE /forums_posts/1.xml
  def destroy
    @post = Forums::Post.find(params[:id])
    @forums_post.destroy
    respond_with(@post)
  end
end
