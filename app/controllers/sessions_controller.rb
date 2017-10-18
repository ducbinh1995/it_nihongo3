class SessionsController < ApplicationController
  attr_reader :user

  def new; end

  def create
    if params.has_key? "basic-login"
      user = User.find_by(email: params[:session][:email].downcase)
      if (user && user.authenticate(params[:session][:password]))
        if user.activated?
          login_success user
        else
          not_activated
        end
      else
        login_fail
      end
    elsif params.has_key? "fb-login"
      user = User.find_by(id: params[:id])
      login_success user
    elsif
      user = User.from_omniauth(request.env["omniauth.auth"])
      @user=user
      render :fb
      #login_success user
    else
      login_fail
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_success user
    log_in user
    session = params[:session]
    session[:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end

  def login_fail
    flash.now[:danger] = 'Invalid email/password combination'
    render :new
  end

  def not_activated
    flash[:warning] = "Account not activated. "
    redirect_to root_url
  end
end
