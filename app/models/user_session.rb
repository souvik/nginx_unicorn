class UserSession
  attr_reader :user

  def initialize(normal_session, fb_session={})
    @password = normal_session[:password]
    @fb_connect = false
    email = normal_session[:email]

    unless normal_session.present?
      @fb_connect = true
      @fb_details = fb_session
      email = fb_session[:email]
    end
    @user = User.where(email: email).first || AnonymousUser.new
  end

  def valid?
    return fb_session_validator if @fb_connect
    return false unless @user.class == User
    @user.authentic_user?(@password)
  end

  def fb_session_validator
    return true if @user.instance_of?(User) && @user.facebook_account.present?
    @user = User.create(first_name: @fb_details[:first_name],
                        last_name: @fb_details[:last_name],
                        location: @fb_details[:location],
                        email: @fb_details[:email],
                        authenticated: true) unless @user.instance_of?(User)
    @user.create_profile_from_fb(@fb_details)
  end
end
