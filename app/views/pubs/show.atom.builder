atom_feed language: I18n.locale do |feed|
  feed.title @pub.name + ' · ' + Raddar::config.app['name']
  feed.updated @stuffs.first.created_at unless @stuffs.empty?

  @stuffs.limit(20).each do |stuff|
    feed.entry stuff do |entry|
      entry.title stuff.name
      entry.content stuff.content, type: 'html'

      entry.author do |author|
        author.name @pub.user.name
      end
    end
  end
end