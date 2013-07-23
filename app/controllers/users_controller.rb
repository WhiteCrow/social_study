# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_reputable, only: [:vote]

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
    @states = Audit.states.in(modifier: @user).desc('created_at').page(params[:page]||1).per(20)
    respond_to do |format|
      format.html
      format.js { render 'states/paginate' }
    end
  end

  # vote useful or useless
  def vote
     # cancel previous votes
    if (reputation = @reputable.reputations.
                                 where(user_id: current_user.id).
                                 in(type: ['useful', 'useless']).first).present?
      @pre_vote_type = reputation.type
      reputation.destroy
    end

    # if previous vote type not equal current vote type, then vote
    if params[:vote_type] != @pre_vote_type
      @reputation = @reputable.reputations.create!({user: current_user, type: params[:vote_type]})
    end
    respond_to do |format|
      format.js
    end
  end

  def get_reputable
    @reputable = params[:reputable_type].constantize.find(params[:reputable_id])
  end
end
