class NotifyForumPostJob < Struct.new(:post_id)
  def perform
    post = Post.find(:post_id).first
    
    post.topic.watchings.each do |watching|
      watching.user.notifications.create content: I18n.t('notification.forum_post.html', author: post.user.name, topic: post.topic.name), item_path: post.url, image_path: post.user.avatar.thumb.url
      NoticeMailer.new_forum_post_email(watching.user, post).deliver if watching.user != post.user
    end
  end
end