class NotifyRankJob < Struct.new(:user_id, :rank_id)
  def perform
    user = User.find user_id
    rank = Rank.find rank_id

    notification = user.notifications.new content: I18n.t('notification.rank.html', name: rank.name), item_path: user.url, image_path: rank.universe.cover.thumb.url
    notification.save
    NoticeMailer.new_rank_email(notification, rank).deliver 
  end
end