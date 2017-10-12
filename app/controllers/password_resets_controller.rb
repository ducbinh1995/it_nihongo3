class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration,
    only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if user
      send_reset_mail
    else
      flash.now[:danger] = "Email address not found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      empty_password
    elsif user.update_attributes user_params
      update_success
    else
      render :edit
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    @user = User.find_by email: params[:email]

    return if user
    flash[:danger] = "User not exist!"
    redirect_to root_path
  end

  def valid_user
    return if user && user.activated? && user.authenticated?(
      :reset, params[:id])
    redirect_to root_url
  end

  def send_reset_mail
    user.create_reset_digest
    user.send_password_reset_email
    flash[:info] = "Email sent with password reset instructions"
    redirect_to root_url
  end

  def check_expiration
    return unless user.password_reset_expired?
    flash[:danger] = "Password reset has expired."
    redirect_to new_password_reset_url
  end

  def empty_password
    user.errors.add :password, "can't be empty"
    render :edit
  end

  def update_success
    user.update_attributes reset_digest: nil
    log_in user
    flash[:success] = "Password has been reset."
    redirect_to user
  end
end
