class Newsletter
  include Raddar::Model

  field :subject, type: String
  field :content, type: String
  field :sent_at, type: Time

  validates_presence_of :subject, :content
  validates_length_of :subject, maximum: 300
  validates_length_of :content, maximum: 60_000
end
