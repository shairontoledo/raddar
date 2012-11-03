module PubsHelper
  def pub_feed_tag pub
    auto_discovery_link_tag :atom, pub_path(pub, format: :atom), title: pub.name
  end

  def main_pubs_span limit=20
    ret = ''
    Pub.where(main: true).to_a.sort_by {|p| p.stuffs.empty? ? p.created_at : p.stuffs.order_by([:created_at, :desc]).first.created_at }.reverse.first(limit).each do |pub|
      unless pub.stuffs.empty?
        ret = ret + render('stuffs/show_resumed', {stuff: pub.stuffs.last})
      end
    end
    raw ret
  end
end
