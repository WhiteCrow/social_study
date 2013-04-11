class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def following
    @user = User.find(params[:id])
    @followers = @user.followers
  end
end
