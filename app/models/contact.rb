class Contact
  include Raddar::Model

  belongs_to :user

  field :name, type: String
  field :email, type: String
  field :message, type: String

  validates_presence_of :name, :email, :message
  validates_length_of :message, maximum: 6_000
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def name
    user.nil? ? self[:name] : user.name
  end
end
