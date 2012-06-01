module Raddar::Searchable

  def self.included base
    base.send :include, Mongoid::FullTextSearch
    base.send :fulltext_search_in, index_name: 'global', filters: { "only_for_#{self.class.name.underscore}" => lambda { |x| true }}
  end

  def to_s
    self[:name]
  end
end