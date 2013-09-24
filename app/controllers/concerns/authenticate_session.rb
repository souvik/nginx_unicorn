module AuthenticateSession
  include ActiveSupport::Concern

  def logged_in?
    current_user.class != AnonymousUser
  end

  def current_user
    User.where(screen_name: session[:screen_name]).first || AnonymousUser.new
  end
end
