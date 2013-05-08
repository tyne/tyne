# Processes authentication
class AuthProcessor

  attr_reader :credentials

  def initialize(credentials)
    @credentials = credentials
  end

  # Creates or finds a user based on the initialized credentials
  #
  # @return TyneAuth::User
  def find_or_create_user
    unless user = User.where(:provider => credentials.provider, :uid => credentials.uid).first
      user = User.create! do |user|
        user.uid = uid
        user.name = name_or_nickname
        user.username = nickname
        user.email = email
        user.token = token
        user.gravatar_id = gravatar_id
        user.provider = provider
        user.notification_email = email
        user.password = Devise.friendly_token[0,20]
      end
    end
    user
  end

  private

  def uid
    credentials.uid
  end

  def provider
    credentials.provider
  end

  def name_or_nickname
    credentials.info.name || nickname
  end

  def nickname
    credentials.info.nickname
  end

  def email
    credentials.info.email
  end

  def gravatar_id
    credentials.extra.raw_info.gravatar_id
  end

  def token
    credentials.credentials.token
  end
end
