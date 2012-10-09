class Admin::HomeController < ApplicationController
  authorize_resource :class => false 

  def index
    authorize! :index, User

    @users_count = User.where(:confirmed_at.exists => true).count

    @pubs_count = Pub.count
    @stuffs_count = Stuff.count

    @forums_count = Forum.count
    @topics_count = Topic.count
    @posts_count = Post.count

    @venues_count = Venue.count

    @comments_count = Comment.count
  end
end
