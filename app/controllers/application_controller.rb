class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "user.flash.filter.logged_in"
    redirect_to login_url
  end
end
