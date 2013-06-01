# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def following
    user = User.find(params[:id])
    @users = user.following.page(params[:page]||1).per(20)
    respond_to do |format|
      format.html{render 'index', locals: {title: "#{user.name}关注的人："}}
    end
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page]||1).per(20)
    respond_to do |format|
      format.html{render 'index', locals: {title: "关注#{user.name}的人："}}
    end
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow @user
    respond_to do |format|
      format.js
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow @user
    respond_to do |format|
      format.js
    end
  end

  def microblogs
    @user = User.find(params[:id])
    @microblogs = Microblog.where(user: @user).desc('created_at').page(params[:page]||1).per(20)
    respond_to do |format|
      format.html
      format.js { render 'microblogs/paginate' }
    end
  end

end
