
module Raddar::Searchable

  def self.included base
    base.send :include, Mongoid::FullTextSearch
    classname = base.name.underscore

    base.send :fulltext_search_in, index_name: 'global', filters: { "only_for_#{classname}".to_sym => lambda { |x| true }}
  end

  def to_s
    self[:name]
  end
end