module Raddar::Model
  
  def votable?
    check_in_association_as :votes, :votable
  end

  def followable?
    check_in_association_as :followers, :followable
  end

  def taggable?
    check_in_association_as :tags, :taggable
  end

  def watchable?
    check_in_association_as :watchings, :watchable
  end

  def add_error field, error
    message = I18n.t("mongoid.errors.models.#{self.class.name.downcase}.attributes.#{field}.#{error}")
    if field == :base
      errors[:base] << message
    else
      errors.add(field, message)
    end
  end

  private
  def check_in_association_as association, as
    ((!self.reflect_on_association(association).nil?) && (self.reflect_on_association(association).as == as))
  end
end