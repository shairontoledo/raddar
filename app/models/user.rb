require_relative 'model.rb'
require 'pp'

class User < Model
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  # User fields
  field :name, type: String
  field :date_of_birth, type: Date
  field :date_of_birth_privacy, type: Symbol, default: :public
  field :gender, type: Symbol
  field :gender_privacy, type: Symbol, default: :public
  field :bio, type: String
  field :email_privacy, type: Symbol, default: :public
  field :facebook_access_token, type: String
  field :facebook_url, type: String
  field :facebook_url_privacy, type: Symbol, default: :public
  mount_uploader :avatar, AvatarUploader

  # Relationships
  has_and_belongs_to_many :roles

  # Validations
  validates_presence_of :name, :date_of_birth, :gender
  validates_uniqueness_of :name
  validates_format_of :name, with: /^(([a-z]|[A-Z]|[0-9]|_)+)$/
  validates_length_of :name, maximum: 20, minimum: 3
  validates_length_of :bio, maximum: 500
  validates_inclusion_of :gender, :in => [:male,:female], allow_blank: false
  validates_inclusion_of :date_of_birth_privacy, :gender_privacy, :email_privacy, :in => [:public,:only_me], allow_blank: false

  # Virtual attributes
  attr_accessor :login
  attr_accessible :login, :avatar, :avatar_cache, :remove_avatar, :name, :email, :date_of_birth, :bio, :password, :password_confirmation, :gender

  validate  do
    add_error(:date_of_birth,:too_young) if (!self.date_of_birth.nil?) && (self.date_of_birth > 13.years.ago.to_date)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :name =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    unless user = self.where(facebook_access_token: access_token.credentials.token).first
      unless user = self.where(email: data.email).first
        user = self.new
        user.email = data.email
        user.password = Devise.friendly_token[0,20]
        user.gender = data.gender.to_sym
        user.name = data.username
        user.date_of_birth = Date.strptime(data.birthday, '%m/%d/%Y') 
        user.confirm!
      end
      user.bio = data.bio if user.bio.blank?
      user.remote_avatar_url = access_token.info.image
      user.facebook_access_token = access_token.credentials.token
    end
    user.facebook_url = data.link
    user.save
    pp user.errors
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def to_param
    self.name
  end

  def role?(role)
    !self.roles.where(name: role).empty?
  end

  def remove_role(role)
    r = Role.where(name: role).first
    self.roles.delete(r)
  end

  def add_role(role)
    r = Role.where(name: role).first
    self.roles << r
  end
end
