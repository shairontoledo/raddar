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
end
