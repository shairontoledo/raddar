class Model
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  def add_error field, error
    errors.add(field, I18n.t("mongoid.errors.models.#{self.class.name.downcase}.attributes.#{field}.#{error}"))
  end
end