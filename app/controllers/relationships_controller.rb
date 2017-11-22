class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    handle_ajax
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    handle_ajax
  end

  private

  def handle_ajax
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
