module HomeHelper
  def search_result_text result, terms
    text = excerpt hide_html(result), terms.first, radius: 100
    text = truncate hide_html(result), length: 100 if text.blank?
    text = highlight text, terms unless text.blank?
    text
  end

  def search_scope_option scope, params
    label = t "#{scope}.p"
    url = search_path q: params[:q], scope: scope
    active_class = ''
    active_class = 'active' if params[:scope] == scope.to_s

    if scope == :all
      label = t 'search.all'
      url = search_path q: params[:q]
      active_class = 'active' if params[:scope].blank?
    end

    raw "<li class=\"#{active_class}\">#{link_to label, url}</li>"
  end

  def tag_btn_size total, i
    sizes = [:large, :default, :small, :mini]
    pos = i / (total / sizes.count)

    sizes[pos >= sizes.count ? sizes.count - 1 : pos]
  end
end
