atom_feed language: I18n.locale do |feed|
  feed.title @pub.name
  feed.updated @pub.updated_at

  @pub.stuffs.order_by([:created_at, :desc]).limit(20).each do |stuff|
    feed.entry stuff, {url: pub_stuff_url(@pub, stuff)} do |entry|
      entry.title stuff.name
      entry.content render('stuffs/feed_body.html', {stuff: stuff}), type: 'html'

      entry.author do |author|
        author.name @pub.user.name
      end
    end
  end
end