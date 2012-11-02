class NotifyCommentJob < Struct.new(:comment_id)
  include Rails.application.routes.url_helpers
  
  def perform
    begin
      comment = Comment.find comment_id
      comment.commentable.watchings.each do |watching|
        if watching.user != comment.user
          notification = watching.user.notifications.new content: I18n.t('notification.comment.html', author: comment.user.name, item: comment.commentable.name), item_path: raddar_path(comment)
          notification.notifiable = comment.user
          notification.save
          NoticeMailer.delay(queue: 'notify_comment').new_comment_email(notification, comment)
        end
      end
    rescue Mongoid::Errors::DocumentNotFound
    end
  end
end