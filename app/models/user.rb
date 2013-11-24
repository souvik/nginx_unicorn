class User < ActiveRecord::Base
  SECRET_KEY = '/Xbdm1lYenBmMkVHyZnxVIVdaqYh0GUhO1fTJDAxA7s='

  attr_reader :password
  attr_accessor :password_confirmation

  validates :first_name, :last_name, presence: true, length: { maximum: 60 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :password, presence: true, confirmation: true

  has_one :facebook_account

  after_validation :set_screen_name

  def password=(password)
    @password = password

    if @password.present?
      self.encrypted_password = encrypt_password(@password)
    end
  end

  def authentic_user?(password)
    decrypt_password(self.encrypted_password) == password
  end

  def create_profile_from_fb(profile)
    fb_account = FacebookAccount.new(user: self, identifier: profile[:id],
                                     username: profile[:username], verified: profile[:verified])
    fb_account.save
  end

  private
  def encrypt_password(password)
    cipher = ActiveSupport::MessageEncryptor.new(SECRET_KEY)
    cipher.encrypt_and_sign(password)
  end

  def decrypt_password(encrypted_pass)
    cipher = ActiveSupport::MessageEncryptor.new(SECRET_KEY)
    cipher.decrypt_and_verify(encrypted_pass)
  end

  def set_screen_name
    return unless self.email.present? && self.screen_name.blank?
    self.screen_name = Digest::MD5.hexdigest(self.email)
  end
end
