module StuffsHelper
  def last_stuffs_carousel
    stuffs = Stuff.where(:image.ne => nil).order_by([:created_at, :desc])
    render('stuffs/carousel', stuffs: stuffs) unless stuffs.empty?
  end
end
