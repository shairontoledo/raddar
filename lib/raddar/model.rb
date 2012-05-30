module Raddar::Model
  
  def watchable?
    (self.reflect_on_association(:watchings).as == :watchable)
  end

  def add_error field, error
    message = I18n.t("mongoid.errors.models.#{self.class.name.downcase}.attributes.#{field}.#{error}")
    if field == :base
      errors[:base] << message
    else
      errors.add(field, message)
    end
  end
end