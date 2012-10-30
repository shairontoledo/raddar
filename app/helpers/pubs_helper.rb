module PubsHelper
  def pub_feed_tag pub
    auto_discovery_link_tag :atom, pub_path(pub, format: :atom), title: pub.name
  end

  def main_pubs_span limit=20
    ret = ''
    Pub.where(main: true).order_by([:updated_at, :desc]).limit(limit).each do |pub|
      unless pub.stuffs.empty?
        ret = ret + render('stuffs/show_resumed', {stuff: pub.stuffs.last})
      end
    end
    raw ret
  end
end
