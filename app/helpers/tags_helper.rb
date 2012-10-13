module TagsHelper
  def tag_scope_option tag, scope, active
    label = t "#{scope}.p"
    url = tag_path tag, scope: scope
    active_class = ''
    active_class = 'active' if active == scope

    if scope == :all
      label = t 'search.all'
      url = tag_path tag
    end

    raw "<li class=\"#{active_class}\">#{link_to label, url}</li>"
  end
end
