class Model

  def add_error field, error
    message = I18n.t("mongoid.errors.models.#{self.class.name.downcase}.attributes.#{field}.#{error}")
    if field == :base
      errors[:base] << message
    else
      errors.add(field, message)
    end
  end
end