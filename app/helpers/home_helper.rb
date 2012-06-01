module HomeHelper
  def search_result_text result, terms
    terms = terms.split
    text = excerpt result.to_s, terms.first, radius: 80
    text = truncate result.to_s, length: 80 if text.blank?
    text = highlight text, terms unless text.blank?
    text
  end
end
