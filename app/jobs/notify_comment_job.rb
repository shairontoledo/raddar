class NotifyCommentJob < Struct.new(:comment_id)
  def perform
    comment = Comment.find(:comment_id).first
    comment.commentable.watchings.each do |watching|
      NoticeMailer.new_comment_email(watching.user, comment).deliver if watching.user != comment.user
    end
  end
end