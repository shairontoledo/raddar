module StuffsHelper
  def last_stuffs_carousel main_pubs_only=false
    limit = 6

    if main_pubs_only
      stuffs = []
      Pub.where(main: true).order_by([:updated_at, :desc]).limit(limit).each do |pub|
        stuffs << pub.stuffs.last
      end
    else
      stuffs = Stuff.where(:image.ne => nil).order_by([:created_at, :desc]).limit(limit)
    end

    render('stuffs/carousel', stuffs: stuffs) unless stuffs.empty?
  end
end
