require_relative 'model.rb'

class User < Model
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

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
  field :gender, type: Symbol
  field :about_me, type: String
  field :signature, type: String

  # Validations
  validates_presence_of :name, :date_of_birth, :gender
  validates_uniqueness_of :name
  validates_format_of :name, with: /^(([a-z]|[A-Z]|[0-9]|-|_)+)$/
  validates_length_of :name, maximum: 20, minimum: 3
  validates_length_of :signature, maximum: 1000
  validates_length_of :about_me, maximum: 60000
  validates_inclusion_of :gender, :in => [:male,:female], allow_blank: false



  validate  do
    add_error(:date_of_birth,:too_young) if (!self.date_of_birth.nil?) && (self.date_of_birth > 13.years.ago.to_date)
  end

  def to_param
    self.name
  end

end
