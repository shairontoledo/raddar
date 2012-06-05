module HomeHelper
  def search_result_text result, terms
    terms = terms.split
    text = excerpt result.to_s, terms.first, radius: 80
    text = truncate result.to_s, length: 80 if text.blank?
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
end
