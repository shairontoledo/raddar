module PubsHelper
  def pub_feed_tag pub
    auto_discovery_link_tag :atom, pub_path(pub, format: :atom), title: pub.name
  end
end
