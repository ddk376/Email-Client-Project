class User < ActiveRecord::Base
  validates :email, :session_token, presence: true
  validates :password, length: { minimum: 8, allow_nil: true}
  validates :email, uniqueness: true

  attr_reader :password
  after_initialize :ensure_session_token
  after_initialize :ensure_associated_contact_info

  has_one :associated_contact_info,
    class_name: 'Contact',
    foreign_key: :email,
    primary_key: :email

  has_many :contacted,
   class_name: 'HasContact',
   foreign_key: :user_id

  has_many :contacts, through: :contacted, source: :been_in_contact_with

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil                                #invokes the public method whose name goes as the first argument just like public_send, except that it the receiver does not respond to it the call returns nil rather than raising an exception
  end

  def self.current_user
    Thread.current[:current_user]
  end

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end


  protected
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def ensure_associated_contact_info
    self.associated_contact_info ||= Contact.new(email: self.email)
  end
end
