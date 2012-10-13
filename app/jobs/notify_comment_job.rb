class NotifyCommentJob < Struct.new(:comment_id)
  include Rails.application.routes.url_helpers
  
  def perform
    comment = Comment.find comment_id
    comment.commentable.watchings.each do |watching|
      if watching.user != comment.user
        notification = watching.user.notifications.new content: I18n.t('notification.comment.html', author: comment.user.name, item: comment.commentable.name), item_path: raddar_path(comment), image_path: comment.user.image.thumb.url, author: comment.user
        notification.save
        NoticeMailer.new_comment_email(notification, comment).deliver 
      end
    end
  end
end