class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  attr_reader :remember_token, :activation_token, :reset_token
  validates :name, presence: true, length: {maximum: Settings.name_length_max}
  validates :email, presence: true,
    length: {maximum: Settings.email_length_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.password_length_min}

  before_save :downcase_email
  before_create :create_activation_digest


  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

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

  def current_user? user
    self == user
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.blank?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    @reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.reset_time.hours.ago
  end

  mount_uploader :avatar, AvatarUploader

  private

  def downcase_email
    self.email = email.downcase
  end

end
