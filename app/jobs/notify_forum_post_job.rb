class NotifyForumPostJob < Struct.new(:post_id)
  def perform
    post = Post.find(:post_id).first
    topic = Topic.find(post.topic_id)
    post.topic.watchings.each do |watching|
      NoticeMailer.new_forum_post_email(watching.user, post).deliver if watching.user != post.user
    end
  end
end