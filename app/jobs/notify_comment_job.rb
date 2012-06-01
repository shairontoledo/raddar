class NotifyCommentJob < Struct.new(:comment_id)
  def perform
    comment = Comment.find(:comment_id).first
    comment.commentable.watchings.each do |watching|
      notification = watching.user.notifications.new content: I18n.t('notification.comment.html', author: comment.user.name, item: comment.commentable.name), item_path: comment.url, image_path: comment.user.avatar.thumb.url
      notification.save
      NoticeMailer.new_comment_email(notification, comment).deliver if watching.user != comment.user
    end
  end
end