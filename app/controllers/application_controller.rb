require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :atom
  helper_method :raddar_path, :comment_path, :post_path, :stuff_path, :topic_path

  check_authorization :unless => :devise_controller?

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
  	if user_signed_in?
      redirect_to root_url, alert: exception.message
    else
      authenticate_user!
    end
  end

  def default_url_options options={}
    {host: 'abc.com'}
  end

  def raddar_path resource, options={}
    send "#{resource.class.name.underscore}_path".to_sym, resource, options
  end

  def comment_path comment, options={}
    raddar_path comment.commentable, anchor: 'comments'
  end

  def post_path post, options = {}
    forum_topic_path post.topic.forum, post.topic, post_id: post.id, anchor: "post_#{post.id}"
  end

  def stuff_path stuff, options={}
    pub_stuff_path stuff.pub, stuff, options
  end

  def topic_path topic, options={}
    forum_topic_path topic.forum, topic, options
  end
end
