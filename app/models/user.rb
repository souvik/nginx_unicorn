class User < ActiveRecord::Base
  SECRET_KEY = '/Xbdm1lYenBmMkVHyZnxVIVdaqYh0GUhO1fTJDAxA7s='

  attr_reader :password
  attr_accessor :password_confirmation

  validates :first_name, :last_name, presence: true, length: { maximum: 60 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :password, presence: true, confirmation: true

  def password=(password)
    @password = password

    if password.present?
      self.encrypted_password = encrypt_password(password)
    end
  end

  def authentic_user?(password)
    decrypt_password(self.encrypted_password) == password
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
end
