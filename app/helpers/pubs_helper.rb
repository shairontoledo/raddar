module PubsHelper
  def pub_feed_tag pub
    auto_discovery_link_tag :atom, pub.url(format: :atom), title: t('pub.feed.title', name: pub.name)
  end
end
