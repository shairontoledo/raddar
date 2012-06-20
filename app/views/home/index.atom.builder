atom_feed language: I18n.locale do |feed|
  feed.title Raddar::config.app['name']
  feed.updated @stuffs.first.created_at unless @stuffs.empty?

  @stuffs.each do |stuff|
    feed.entry stuff do |entry|
      entry.title stuff.name
      entry.content stuff.content, type: 'html'

      entry.author do |author|
        author.name stuff.pub.user.name
      end
    end
  end
end