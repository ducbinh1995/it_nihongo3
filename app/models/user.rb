class User < ApplicationRecord
  attr_accessor :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.name_length_max}
  validates :email, presence: true,
    length: {maximum: Settings.email_length_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.password_length_min}
  before_save {self.email= email.downcase}

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(provider:
      auth_hash["provider"])
    #user.id= auth_hash["info"]["uid"]
    user.email = auth_hash["info"]["email"]
    user.name = auth_hash["info"]["first_name"].to_s + " " +
      auth_hash["info"]["last_name"].to_s
    user.password = "123456"
    user.oauth_token = auth_hash["credentials"]["token"]
    user.oauth_expires_at = auth_hash["credentials"]["expires_at"]
    user.save!
    user
  end
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  mount_uploader :avatar, AvatarUploader
end
