# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def following
    user = User.find(params[:id])
    @users = user.following.page(params[:page]||1).per(48)
    respond_to do |format|
      format.html{render 'index', locals: {title: "#{user.name}关注的人："}}
    end
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page]||1).per(48)
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

  def states
    @user = User.find(params[:id])
    @states = Audit.states.in(modifier: current_user).desc('created_at').page(params[:page]||1).per(20)
    respond_to do |format|
      format.html
      format.js { render 'states/paginate' }
    end
  end

  def relay
    relayable_class = params[:relay][:relayable_type].constantize
    relayable_id = params[:relay][:relayable_id]
    relayable = relayable_class.find(relayable_id)

    if relayable.user != current_user
      if current_user.relay?(relayable)
        current_user.unrelay(relayable)
      else
        current_user.relay(relayable)
      end
      respond_to do |format|
        format.html{ render action: :show }
        format.js
      end
    end
  end

end
