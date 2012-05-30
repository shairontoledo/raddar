class NoticeMailer < ActionMailer::Base
  helper :application
  default from: "System <from@example.com>"

  def new_forum_post_email(user,post)
    @user = user
    @post = post
    @post_url = forum_topic_url(@post.topic.forum, @post.topic, post_id: @post.id)+"#post_#{@post.id}"

    send_mail @user, I18n.t('notice_mailer.subject.new_forum_post')
  end

  def new_comment_email(user, comment)
    @user = user
    @comment = comment
    @comment_url = url_for(@comment.commentable)+"#comments"
    @unwatch_url = eval("#{@comment.commentable.class.name.underscore}_watching_url(@comment.commentable)")

    send_mail @user, I18n.t('notice_mailer.subject.comment')
  end

  def new_message_email(message)
    @user = message.recipient
    @message = message

    send_mail @user, I18n.t('notice_mailer.subject.new_message', sender: message.sender.name)
  end

  def new_follower_email(user, follower)
    @user = user
    @follower = follower

    send_mail @user, I18n.t('notice_mailer.subject.new_follower', follower: follower.name)
  end

  private
  def send_mail user, subject
    title = I18n.t('application.title')


    mail to: "#{user.name} <#{user.email}>", subject: "#{title} - #{subject}"
  end
end
