class UserSession
  attr_reader :user

  def initialize(email='', password='')
    @user = User.where(email: email, password: password).first || AnonymousUser.new
  end

  def valid?
    @user.class == User
  end
end
