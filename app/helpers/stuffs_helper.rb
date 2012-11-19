module StuffsHelper
  def last_stuffs_carousel main_pubs_only=false
    limit = 6

    stuffs = []

    if main_pubs_only
      pubs = Pub.where(main: true).to_a
    else
      pubs = Pub.all.to_a
    end

    pubs.sort_by {|p| p.stuffs.empty? ? p.created_at : p.stuffs.order_by([:created_at, :desc]).first.created_at }.reverse.each do |pub|
      stuffs << pub.stuffs.last unless pub.stuffs.empty? || pub.stuffs.last.image.file.nil?
      break if stuffs.count >= limit
    end

    render('stuffs/carousel', stuffs: stuffs) unless stuffs.empty?
  end

  def last_stuffs_span limit, main_pubs_only=false
    ret = ''

    stuffs = []

    if main_pubs_only
      pubs = Pub.where(main: true).to_a
    else
      pubs = Pub.all.to_a
    end

    pubs.sort_by {|p| p.stuffs.empty? ? p.created_at : p.stuffs.order_by([:created_at, :desc]).first.created_at }.reverse.each do |pub|
      stuffs << pub.stuffs.last unless pub.stuffs.empty? || pub.stuffs.last.image.file.nil?
      break if stuffs.count >= limit
    end

    stuffs.each do |stuff|
      ret = ret + render('stuffs/show_resumed', {stuff: stuff})
    end

    raw ret
  end
end
