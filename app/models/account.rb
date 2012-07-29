class Account
  include Raddar::Model

  belongs_to :user

  field :provider, type: Symbol
  field :token, type: String
  field :secret, type: String
  field :name, type: String
  field :url, type: String
  field :email, type: String
  field :verified, type: Boolean
  field :url_privacy, type: Symbol, default: :public

  validates_presence_of :user, :provider, :token, :name, :url, :url_privacy
  validates_uniqueness_of :token, :name, :url, scope: :provider
  validates_uniqueness_of :provider, scope: :user_id
  validates_inclusion_of :url_privacy, :in => [:public,:only_me], allow_blank: false
end
