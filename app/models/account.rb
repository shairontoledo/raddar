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

  def fill_in_with user, access_data

    self.provider = access_data.provider.to_sym
    self.token = access_data.credentials.token
    self.secret = access_data.credentials.secret
   
    if self.provider == :facebook
      data = access_data.extra.raw_info

      oauth_gender = data.gender
      oauth_date_of_birth = data.birthday.nil? ? nil : Date.strptime(data.birthday, '%m/%d/%Y')
      oauth_bio = data.bio
      oauth_location = data.location.name
      oauth_image_url = access_data.info.image

      self.verified = data.verified
      self.name = data.username
      self.url  = data.link
      self.email = data.email
    end

    if self.provider == :twitter
      oauth_bio = access_data.info.description
      oauth_location = access_data.info.location
      oauth_image_url = access_data.info.image.gsub('_normal','') unless access_data.info.image.blank?

      self.name = access_data.info.nickname
      self.url  = access_data.info.urls.Twitter
    end

    user.email = self.email if user.email.blank?
    user.gender = oauth_gender if user.gender.blank?
    user.name = self.name if user.name.blank?
    user.date_of_birth = oauth_date_of_birth if user.date_of_birth.blank?
    user.bio = oauth_bio if user.bio.blank?
    user.location = oauth_location if user.location.blank?
    user.remote_image_url = oauth_image_url if user.image.file.nil?

    if user.valid?
      user.confirm! unless user.confirmed?
      user.save
    end

    self.user = user
    
    self.save
  end

  def self.find_for_oauth access_data, current_user=nil

    provider = access_data.provider.to_sym

    account = self.where(provider: provider).and(token: access_data.credentials.token).and(secret: access_data.credentials.secret).and(:user_id.ne => nil).first

    account.destroy if (!account.nil?) && account.user.nil?

    if account.nil? || account.frozen?
      user = current_user

      if user.nil?
        user = User.where(email: access_data.extra.raw_info.email).first if provider == :facebook

        user = User.new(password: Devise.friendly_token[0,20]) if user.nil?
      end

      account = self.new
    else
      user = account.user
    end

    account.fill_in_with user, access_data

    account
  end
end