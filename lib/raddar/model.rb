module Raddar::Model

  def self.included base
    base.send :include, Mongoid::Document
    base.send :include, Mongoid::Timestamps
  end
  
  def votable?
    check_in_association_as :votes, :votable
  end

  def followable?
    check_in_association_as :followers, :followable
  end

  def taggable?
    check_in_association_as :taggings, :taggable
  end

  def watchable?
    check_in_association_as :watchings, :watchable
  end

  def commentable?
    check_in_association_as :comments, :commentable
  end

  def notifiable?
    check_in_association_as :triggered_notifications, :notifiable
  end

  def searchable?
    kind_of? Raddar::Searchable
  end

  def add_error field, error
    message = I18n.t("mongoid.errors.models.#{self.class.name.downcase}.attributes.#{field}.#{error}")
    if field == :base
      errors[:base] << message
    else
      errors.add(field, message)
    end
  end

  
  def description
    self[:description] || self.to_s
  end

  private
  def check_in_association_as association, as
    ((!self.reflect_on_association(association).nil?) && (self.reflect_on_association(association).as == as))
  end
end