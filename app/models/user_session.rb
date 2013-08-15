class UserSession
  attr_reader :user

  def initialize(email='', password='')
    @password = password
    @user = User.where(email: email).first || AnonymousUser.new
  end

  def valid?
    return false unless @user.class == User
    @user.authentic_user?(@password)
  end
end
