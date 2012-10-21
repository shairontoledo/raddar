atom_feed language: I18n.locale do |feed|
  feed.title Raddar::config.name
  feed.updated @stuffs.first.created_at unless @stuffs.empty?

  @stuffs.limit(20).each do |stuff|
    feed.entry stuff, {url: pub_stuff_url(stuff.pub, stuff)} do |entry|
      entry.title stuff.name
      entry.content render('stuffs/feed_body.html', {stuff: stuff}), type: 'html'

      entry.author do |author|
        author.name stuff.pub.user.name
      end
    end
  end
end