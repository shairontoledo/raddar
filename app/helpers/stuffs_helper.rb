module StuffsHelper
  def last_stuffs_carousel main_pubs_only=false
    limit = 6

    if main_pubs_only
      stuffs = []
      Pub.where(main: true).to_a.sort_by {|p| p.stuffs.empty? ? p.created_at : p.stuffs.order_by([:created_at, :desc]).first.created_at }.reverse.first(limit).each do |pub|
        stuffs << pub.stuffs.last unless pub.stuffs.empty?
      end
    else
      stuffs = Stuff.where(:image.ne => nil).order_by([:created_at, :desc]).limit(limit)
    end

    render('stuffs/carousel', stuffs: stuffs) unless stuffs.empty?
  end
end
