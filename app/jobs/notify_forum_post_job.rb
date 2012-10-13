
class NotifyForumPostJob < Struct.new(:post_id)
  include Rails.application.routes.url_helpers
  
  def perform
    post = Post.find post_id
    
    post.topic.watchings.each do |watching|
      if watching.user != post.user
        notification = watching.user.notifications.new content: I18n.t('notification.forum_post.html', author: post.user.name, topic: post.topic.name), item_path: raddar_path(post), image_path: post.user.image.thumb.url, author: post.user
        notification.save
        NoticeMailer.new_forum_post_email(notification, post).deliver 
      end
    end
  end
end