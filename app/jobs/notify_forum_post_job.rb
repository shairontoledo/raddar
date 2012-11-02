
class NotifyForumPostJob < Struct.new(:post_id)
  include Rails.application.routes.url_helpers
  
  def perform
    begin
      post = Post.find post_id
      
      post.topic.watchings.each do |watching|
        if watching.user != post.user
          notification = watching.user.notifications.new content: I18n.t('notification.forum_post.html', author: post.user.name, topic: post.topic.name), item_path: raddar_path(post)
          notification.notifiable = post.user
          notification.save
          NoticeMailer.delay(queue: 'notify_post').new_forum_post_email(notification, post).deliver 
        end
      end
    rescue Mongoid::Errors::DocumentNotFound
    end
  end
end