module ApplicationHelper
  def page_title *args
    content_for :page_title do
      args.join(' ')
    end
  end

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

  def edit_button path
    render 'shared/edit_button', {path: path}
  end

  def destroy_button path, text='action.delete'
    render 'shared/destroy_button', {path: path, text: text}
  end

  def thumbnail url, imageclass=nil
    raw "<ul class=\"thumbnails\"><li><div class=\"thumbnail\">#{image_tag url, :class => imageclass}</div></li></ul>"
  end
end
