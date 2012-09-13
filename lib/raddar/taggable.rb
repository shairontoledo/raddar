module Raddar::Taggable

  def self.included base
    base.send :has_many, :taggings, as: :taggable, dependent: :destroy
    base.send :attr_accessible, :tags
    base.send :after_save, :set_taggings
  end

  def tags
    text = ''
    if self[:tagnames].nil?
      tags = []
      self.taggings.each{|tagging| tags << tagging.tag.name}

      text = tags.join ', '
    else
      text = self[:tagnames]
    end
    text
  end

  def tags=(tagnames)
    self[:tagnames] = tagnames
  end

  private
  def set_taggings
    unless self[:tagnames].nil?
      self.taggings.destroy_all
      tag_names = self[:tagnames].split(',')
      self.unset :tagnames
      tag_names.each do |tagname|
        tagname.strip!
        tagname.downcase!
        tag = Tag.find_or_create_by name: tagname
        if( (!tag.nil?) && tag.persisted?)
          self.taggings.create(tag_id: tag.id)
        end
      end
    end
  end
end