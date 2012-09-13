require Rails.root.join('lib', 'devise', 'encryptors', Raddar::config.authentication['encryptor'])

class User
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Followable
  include Raddar::Searchable

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, 
         :encryptable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  validates_presence_of :email
  validates_presence_of :encrypted_password

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
  field :password_salt, :type => String

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
  field :status, type: Symbol, default: :active
  mount_uploader :image, ImageUploader
  field :location, type: String
  field :location_privacy, type: Symbol, default: :public
  field :notify_messages, type: Boolean, default: true
  field :notify_followers, type: Boolean, default: true
  slug :name

  # Relationships
  has_and_belongs_to_many :roles, dependent: :nullify
  has_many :sent_messages, class_name: 'Message', inverse_of: :sender, dependent: :destroy
  has_many :incoming_messages, class_name: 'Message', inverse_of: :recipient, dependent: :destroy
  has_many :followerships, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :pubs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :watchings, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :venues, dependent: :nullify
  has_and_belongs_to_many :ranks, dependent: :nullify
  has_many :accounts

  # Validations
  validates_presence_of :name, :date_of_birth, :gender, :status
  validates_uniqueness_of :name
  validates_format_of :name, with: /^(([a-z]|[A-Z]|[0-9]|_)+)$/
  validates_length_of :name, maximum: 20, minimum: 3
  validates_length_of :bio, maximum: 500
  validates_length_of :location, maximum: 200
  validates_inclusion_of :gender, :in => [:male,:female], allow_blank: false
  validates_inclusion_of :status, :in => [:active,:blocked], allow_blank: false
  validates_inclusion_of :date_of_birth_privacy, :gender_privacy, :email_privacy, :location_privacy,
    :in => [:public,:only_me], allow_blank: false

  # Virtual attributes
  attr_accessor :login

  # Accessible (mass assignment)
  attr_accessible :login, :image, :image_cache, :remove_image, :email, :name, :date_of_birth, :location,
    :bio, :password, :password_confirmation, :gender, :facebook_access_token, :facebook_url, :remote_image_url

  validate  do
    add_error(:date_of_birth,:too_young) if (!self.date_of_birth.nil?) && (self.date_of_birth > 13.years.ago.to_date)
  end

  def self.find_first_by_auth_conditions warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ name:  /^#{Regexp.escape(login)}$/i }, { email:  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end

  def self.find_for_oauth access_data, user=nil

    provider = access_data.provider.to_sym

    if provider == :facebook
      account = Account.where(provider: provider).and(token: access_data.credentials.token).first
    else
      account = Account.where(provider: provider).and(token: access_data.credentials.token).and(secret: access_data.credentials.secret).first
    end

    if user.nil?
      
      user = account.user unless account.nil?

      if user.nil?

        user = User.where(email: access_data.extra.raw_info.email).first if provider == :facebook

        if user.nil?
          user = User.new
          user.password = Devise.friendly_token[0,20]
        end 
      end
    end

    user.add_oauth_account access_data
    user.save

    if user.persisted? 
      user.confirm! unless user.confirmed?
    end

    user
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session['devise.oauth_temp_data']
        user.add_oauth_account data
      end
    end
  end

  def role?(role)
    !self.roles.where(name: role).empty?
  end

  def active?
    self.status == :active
  end

  def active_for_authentication?
    super && self.active?
  end

  def inactive_message
     self.active? ? super : I18n.t('flash.account.blocked')
  end

  def add_oauth_account access_data

    provider = access_data.provider.to_sym

    account = Account.new 
    account.provider = provider
    account.token = access_data.credentials.token
    account.secret = access_data.credentials.secret
   
    if provider == :facebook
      data = access_data.extra.raw_info

      oauth_gender = data.gender
      oauth_date_of_birth = Date.strptime(data.birthday, '%m/%d/%Y')
      oauth_bio = data.bio
      oauth_location = data.location.name
      oauth_image_url = access_data.info.image

      account.verified = data.verified
      account.name = data.username
      account.url  = data.link
      account.email = data.email
    end

    if provider == :twitter

      oauth_bio = access_data.info.description
      oauth_location = access_data.info.location
      oauth_image_url = access_data.info.image

      account.name = access_data.info.nickname
      account.url  = access_data.info.urls.Twitter
    end

    self.email = account.email if self.email.blank?
    self.gender = oauth_gender if self.gender.blank?
    self.name = account.name if self.name.blank?
    self.date_of_birth = oauth_date_of_birth if self.date_of_birth.blank?
    self.bio = oauth_bio if self.bio.blank?
    self.location = oauth_location if self.location.blank?
    self.remote_image_url = oauth_image_url if self.image.file.nil?
    
    if account.valid?
      account.user = self
      account.save
    end

    account
  end

  def update_password_with_password(params, *options)
    current_password = params.delete(:current_password)

    result = if valid_password?(current_password)
      update_attributes(params, *options)
    else
      self.assign_attributes(params, *options)
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end
end
