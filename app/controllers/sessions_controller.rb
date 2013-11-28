class SessionsController < ApplicationController
  ssl_required :new, :create, :destroy
  perform_authorization_for :destroy

  def new
  end

  def create
    user_session = fb_login? ? UserSession.new({}, params[:fb_session]) : UserSession.new({email: params[:email], password: params[:password]})
    authenticity_validated = user_session.valid?

    if authenticity_validated
      current_user = user_session.user
      session[:screen_name] = current_user.screen_name
    end

    if request.xhr?
      render json: {validated: authenticity_validated}, status: (authenticity_validated ? :created : :unprocessible_entity)
    else
      authenticity_validated ? redirect_to(profile_path(current_user.screen_name)) : render(action: :new, notice: "Invalid Email/Password")
    end
  end

  def destroy
    reset_session
    redirect_to root_url(secure: false)
  end

  private
  def fb_login?
    params[:fb_session].present?
  end
end
