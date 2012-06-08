module TagsHelper
  def tag_result_text result, tag
    text = excerpt result.to_s, tag.name, radius: 80
    text = truncate result.to_s, length: 80 if text.blank?
    text = highlight text, tag.name unless text.blank?
    text
  end

  def tag_scope_option tag, scope, active
    label = t "#{scope}.p"
    url = tag.url scope: scope
    active_class = ''
    active_class = 'active' if active == scope

    if scope == :all
      label = t 'search.all'
      url = tag.url
    end

    raw "<li class=\"#{active_class}\">#{link_to label, url}</li>"
  end
end
