module Raddar::Taggable

  def self.included base
    base.send :has_many, :taggings, as: :taggable, dependent: :destroy
    base.send :attr_accessible, :tags
  end

  def tags
    tags = []
    self.taggings.each{|tagging| tags << tagging.tag.name}

    tags.join(', ')
  end

  def tags=(tagnames)
    tagnames.split(',').each do |tagname|
      tagname.strip!
      tagname.downcase!
      tag = Tag.find_or_create_by name: tagname
      if self.taggings.where(tag_id: tag.id).empty?
        self.taggings.create(tag_id: tag.id)
      end
    end
  end
end