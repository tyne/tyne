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
    unless user = User.find_by_uid(uid)
      user = User.create! do |user|
        user.uid = uid
        user.name = name_or_nickname
        user.username = nickname
        user.email = email
        user.token = token
        user.gravatar_id = gravatar_id
      end
    end
    user
  end

  private

  def uid
    credentials["uid"]
  end

  def name_or_nickname
    if credentials["info"]["name"].present?
      credentials["info"]["name"]
    else
      nickname
    end
  end

  def nickname
    credentials["info"]["nickname"]
  end

  def email
    credentials["info"]["email"]
  end

  def gravatar_id
    credentials["extra"]["raw_info"]["gravatar_id"]
  end

  def token
    credentials["credentials"]["token"]
  end
end
