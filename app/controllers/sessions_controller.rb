class SessionsController < ApplicationController
  attr_reader :user

  def new; end

  def create
    if params[:session].present?
      user = User.find_by(email: params[:session][:email].downcase)
      if (user && user.authenticate(params[:session][:password]))
          log_in user
          remember user
          redirect_to root_url
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    else
      user = User.from_omniauth(request.env["omniauth.auth"])
      log_in user
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
