class UsersController < ApplicationController
  ssl_required :new, :create

  def new
    @user = User.new
    render layout: 'sessions'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to profile_path(@user)
    else
      render action: :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :password, :password_confirmation)
  end
end
