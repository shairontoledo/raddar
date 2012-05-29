module ApplicationHelper
  def humanize_datetime datetime
    str = ''
    if datetime > 1.day.ago
      str = distance_of_time_in_words_to_now datetime
    else
      str = l(datetime, format: :short)
    end
    str
  end

  def rich_format html
    sanitize html
  end

  def simple_text text
    sanitize simple_format(text), tags: %w{p br}, attributes: []
  end

  def watchable? item
    (item.reflect_on_association(:watchings).as == :watchable)
  end
end
