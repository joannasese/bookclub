class UsersController < ApplicationController

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
      flash[:success] = "You're all signed up!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :uid)
    end

end
