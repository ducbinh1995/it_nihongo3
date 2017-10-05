class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit :username, :name, :gender, :email, :password,
      :password_confirmation
  end
end
