class NotifyRankJob < Struct.new(:user_id, :rank_id)
  include Rails.application.routes.url_helpers
  
  def perform
    begin
      user = User.find user_id
      rank = Rank.find rank_id

      notification = user.notifications.new content: I18n.t('notification.rank.html', name: rank.name), item_path: user_path(user)
      notification.notifiable = rank.universe
      notification.save
      NoticeMailer.delay(queue: 'notify_rank').new_rank_email(notification, rank)
    rescue Mongoid::Errors::DocumentNotFound
    end
  end
end