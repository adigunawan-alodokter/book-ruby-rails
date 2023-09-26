class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password # Virtual attribute for handling the password

  field :name, type: String
  field :username, type: String
  field :email, type: String
  field :password_digest, type: String

  before_save :encrypt_password

  def authenticate(plain_password)
    BCrypt::Password.new(password_digest) == plain_password
  end

  private

  def encrypt_password
    if password.present?
      self.password_digest = BCrypt::Password.create(password)
    end
  end
end
