require Rails.root.join('lib', 'devise', 'encryptors', Raddar::config.authentication['encryptor'])

class User
  include Raddar::Model
  include Mongoid::Slug
  include Raddar::Followable
  include Raddar::Searchable

  # Include default devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :encryptable

  ## Database authenticatable
  field :email, type: String, default: ''
  field :encrypted_password, type: String, default: ''
  validates_presence_of :email
  validates_presence_of :encrypted_password
  ## Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time
  ## Rememberable
  field :remember_created_at, type: Time
  ## Trackable
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String
  ## Encryptable
  field :password_salt, type: String
  ## Confirmable
  field :confirmation_token, type: String
  field :confirmed_at, type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email, type: String # Only if using reconfirmable
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
  has_many :notifications, class_name: 'Notification', inverse_of: :user, dependent: :destroy
  has_many :triggered_notifications, class_name: 'Notification', inverse_of: :author, dependent: :destroy
  has_many :venues, dependent: :nullify
  has_and_belongs_to_many :ranks, dependent: :nullify
  has_many :accounts, dependent: :destroy

  # Validations
  validates_presence_of :name, :date_of_birth, :gender, :status
  validates_uniqueness_of :name, case_sensitive: false
  validates_format_of :name, with: /^(([a-z]|[A-Z]|[0-9]|_)+)$/
  validates_length_of :name, maximum: 20, minimum: 3
  validates_length_of :bio, maximum: 500
  validates_length_of :location, maximum: 200
  validates_inclusion_of :gender, :in => [:male,:female], allow_blank: false
  validates_inclusion_of :status, :in => [:active,:blocked], allow_blank: false
  validates_inclusion_of :date_of_birth_privacy, :gender_privacy, :email_privacy, :location_privacy, :in => [:public,:only_me], allow_blank: false
  validate { add_error(:date_of_birth,:too_young) if (!self.date_of_birth.nil?) && (self.date_of_birth > 13.years.ago.to_date) }

  # Virtual attributes
  attr_accessor :login

  # Accessible (mass assignment)
  attr_accessible :login, :image, :image_cache, :remove_image, :email, :name, :date_of_birth, :location,
    :bio, :password, :password_confirmation, :gender, :facebook_access_token, :facebook_url, :remote_image_url

  def self.find_first_by_auth_conditions warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ name:  /^#{Regexp.escape(login)}$/i }, { email:  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session['devise.oauth_temp_data']
        account = Account.new
        account.fill_in_with user, data
        account.user
      end
    end
  end

  def role?(role)
    !self.roles.where(name: role).empty?
  end

  def active?
    (self.status == :active) && self.confirmed?
  end

  def active_for_authentication?
    super && self.active?
  end

  def inactive_message
    (self.status == :active) ? super : I18n.t('flash.account.blocked')
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

  def description
    self.bio
  end
end
