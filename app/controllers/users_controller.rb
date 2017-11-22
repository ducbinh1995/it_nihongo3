class UsersController < ApplicationController
  require 'will_paginate/array'
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @myreviews = Review.where('user_id LIKE ?', "#{@user.id}").paginate(page: params[:page], :per_page => 10)
    @listlikereviews = []
    @likes = @user.likes
    @likes.each do |like|
      @listlikereviews.push like.review
    end
    @listlikereviews.paginate(page: params[:page], :per_page => 10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      render :show
    else
      render :edit
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit :username, :name, :gender, :email, :password,
      :password_confirmation, :avatar
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
