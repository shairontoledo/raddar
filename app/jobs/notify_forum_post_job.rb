
class NotifyForumPostJob < Struct.new(:post_id)
  def perform
    post = Post.find post_id
    
    post.topic.watchings.each do |watching|
      if watching.user != post.user
        notification = watching.user.notifications.new content: I18n.t('notification.forum_post.html', author: post.user.name, topic: post.topic.name), item_path: post.url, image_path: post.user.avatar.thumb.url
        notification.save
        NoticeMailer.new_forum_post_email(notification, post).deliver 
      end
    end
  end
end