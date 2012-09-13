module ApplicationHelper
  def page_title *args
    content_for :page_title do
      args.join(' ')
    end
  end

  def humanize_datetime datetime
    str = ''
    if datetime > 1.week.ago
      str = distance_of_time_in_words_to_now datetime
    elsif datetime > 1.year.ago
      str = l(datetime.to_date, format: :short)
    else
      str = l(datetime.to_date, format: :long)
    end
    str
  end

  def rich_format html
    sanitize html
  end

  def hide_html text
    sanitize simple_format(text), tags: [], attributes: []
  end

  def simple_text text
    sanitize simple_format(text), tags: %w{p br}, attributes: []
  end

  def edit_button path
    render 'shared/edit_button', {path: path}
  end

  def submit_button form, label=nil
    render 'shared/submit_button', {form: form, label: label}
  end

  def back_button
    render 'shared/back_button'
  end

  def destroy_button path, text='action.delete'
    render 'shared/destroy_button', {path: path, text: text}
  end

  def thumbnail url, imageclass=nil
    raw "<ul class=\"thumbnails\"><li><div class=\"thumbnail\">#{image_tag url, :class => imageclass}</div></li></ul>"
  end

  def captcha model_instance
    render 'shared/captcha', {model_instance: model_instance} if Raddar::config.recaptcha['enabled']
  end
end
