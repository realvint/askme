require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest.new('SHA256')
  USERNAME_MAX_LENGTH = 40
  VALID_HEADER_COLOR = /\A#[\da-f]{6}\z/i

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :username, length: { maximum: USERNAME_MAX_LENGTH },
                       presence: true, uniqueness: true, format: { with: /\A\w+\z/ }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates :password, confirmation: true
  validates :header_color, format: { with: VALID_HEADER_COLOR }, allow_blank: true

  before_validation :downcase_email_and_username
  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    if user.present? && user.password_hash == User
       .hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  private

  def downcase_email_and_username
    email&.downcase!
    username&.downcase!
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end
end
