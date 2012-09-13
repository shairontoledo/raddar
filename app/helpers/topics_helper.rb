module TopicsHelper
  def posts_count topic
    c = topic.posts.count
    word = c == 1 ? t('post.s') : t('post.p')

    "#{c} #{word.downcase}"
  end
end
