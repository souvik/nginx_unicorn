class SessionsController < ApplicationController
  def new
  end

  def create
    user_session = UserSession.new(params[:email], params[:password])

    if user_session.valid?
      current_user = user_session.user
      session[:screen_name] = current_user.screen_name
      redirect_to profile_path(current_user.screen_name)
    else
      flash[:notice] = "Invalid Email/Password"
      render action: :new
    end
  end
end
