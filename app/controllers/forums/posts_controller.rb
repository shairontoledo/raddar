class Forums::PostsController < ApplicationController
  load_and_authorize_resource

  # POST /forums_posts
  # POST /forums_posts.xml
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(params[:post])
    @post.user = current_user
    if @post.save
      current_user.watchings.create(watchable: @topic) if params[:post][:watch] == '1'

      Delayed::Job.enqueue NotifyForumPostJob.new(@post.id)

      respond_with(@post, location: forum_topic_path(@forum,@topic, post_id: @post.id)+"#post_#{@post.id}")
    else
      @posts = @topic.first_posts.paginate(page: params[:page], per_page: 10)
      render 'forums/topics/show'
    end
  end


  # DELETE /forums_posts/1
  # DELETE /forums_posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_with(@post, location: [@post.topic.forum,@post.topic])
  end
end
