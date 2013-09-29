class UsersController < ApplicationController
  ssl_required :new, :create, :show
  perform_authorization_for :show

  def new
    @user = User.new
    render layout: 'sessions'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:screen_name] = @user.screen_name
      redirect_to profile_path(@user)
    else
      render action: :new
    end
  end

  def show
    @user = User.where(screen_name: params[:screen_name]).first
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :password, :password_confirmation)
  end
end
