class NotifyForumPostJob < Struct.new(:post_id)
  def perform
    post = Post.find(:post_id).first
    topic = Topic.find(post.topic_id)
    post.topic.watchers.each do |watcher|
      NoticeMailer.new_forum_post_email(watcher, post).deliver if watcher != post.user
    end
  end
end