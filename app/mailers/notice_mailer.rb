class NoticeMailer < ActionMailer::Base
  helper :application
  layout 'mailer'
  default from: Raddar::config.email['from']

  def new_forum_post_email(notification, post)
    @notification = notification
    @post = post

    send_mail @notification.user, I18n.t('notice_mailer.subject.new_forum_post')
  end

  def new_comment_email(notification, comment)
    @notification = notification
    @comment = comment
    @unwatch_url = polymorphic_url([@comment.commentable, :watching], action: :unwatch)

    send_mail @notification.user, I18n.t('notice_mailer.subject.new_comment')
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

  def new_rank_email(notification, rank)
    @notification = notification
    @rank = rank

    send_mail @notification.user, I18n.t('notice_mailer.subject.new_rank', rank: rank.name)
  end

  private
  def send_mail user, subject

    mail to: "#{user.name} <#{user.email}>", subject: subject
  end
end
