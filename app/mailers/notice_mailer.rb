class NoticeMailer < ActionMailer::Base
  helper :application
  default from: "System <from@example.com>"

  def new_forum_post_email(notification, post)
    @notification = notification
    @post = post

    send_mail @notification.user, I18n.t('notice_mailer.subject.new_forum_post')
  end

  def new_comment_email(notification, comment)
    @notification = notification
    @comment = comment
    @unwatch_url = polymorphic_path([@comment.commentable, :watching])

    send_mail @notification.user, I18n.t('notice_mailer.subject.comment')
  end

  def new_message_email(message)
    @user = message.recipient
    @message = message

    send_mail @user, I18n.t('notice_mailer.subject.new_message', sender: message.sender.name)
  end

  def new_follower_email(notification, follower)
    @notification = notification
    @follower = follower

    send_mail @notification.user, I18n.t('notice_mailer.subject.new_follower', follower: follower.name)
  end

  private
  def send_mail user, subject
    title = I18n.t('application.title')


    mail to: "#{user.name} <#{user.email}>", subject: "#{title} - #{subject}"
  end
end
