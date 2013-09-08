# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :notes, :knowledges, :resources, :notes, :reviews, :experiences, :states]
  before_filter :get_reputable, only: [:vote, :study, :grade, :collect]

  def show
    @user = User.find(params[:id])
    @entry = @user.special_entry_by('default')
    @partial_path = 'entries/index'
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
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
    @states = Audit.state.in(modifier: @user).desc('created_at').page(params[:page]||1).per(20)
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
                                 in(type: Reputation::VoteTypes).first).present?
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

  def study
    # cancel previous study
    if (reputation = @reputable.reputations.
                                 where(user_id: current_user.id).
                                 in(type: Reputation::StudyTypes).first).present?
      @pre_study_type = reputation.type
      reputation.destroy
    end
    if params[:study_type] != @pre_study_type
      @reputable.reputations.create!({user: current_user, type: params[:study_type]})
      @study_state = params[:study_type]
    end
    respond_to do |format|
      format.js
    end
  end

  def grade
    # cancel previous grade
    if (reputation = @reputable.reputations.
                                 where(user_id: current_user.id).
                                 in(type: Reputation::GradeTypes).first).present?
      @pre_grade_type = reputation.type
      reputation.destroy
    end
    if params[:grade_type] != @pre_grade_type
      @reputable.reputations.create!({user: current_user, type: params[:grade_type]})
      @grade_state = params[:grade_type]
    end
    respond_to do |format|
      format.js
    end
  end

  def collect
    if (reputation = @reputable.reputations.
                              where(user_id: current_user.id).
                              in(type: 'collect').first).present?
      reputation.destroy
    else
      @reputable.reputations.create!({user: current_user, type: params[:collect_type]})
      @collect_state = params[:collect_type]
    end
    respond_to do |format|
      format.js
    end
  end

  def describe
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update_describe
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.js
      else
        format.js {'cancel_describe'}
      end
    end
  end

  def cancel_describe
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  ["notes", "experiences", "reviews"].each do |field|
    define_method field do
      @user = User.find(params[:id])
      @items = @user.send(field)
      @partial_path = 'common/leaves'
      render template: 'users/show'
    end
  end

  def knowledges
    @user = User.find(params[:id])
    types = params[:type].present? ? params[:type] :  Reputation::StudyTypes
    @reputations = Kaminari.paginate_array(
                              @user.reputations.knowledges.in(type: types)
                            ).page(params[:page]).per(10)
    @reputation_types = Reputation::StudyTypes
    @partial_path = 'nodes'
    render template: 'users/show'
  end

  def resources
    @user = User.find(params[:id])
    types = params[:type].present? ? Reputation::GradeTypes : ['collect']
    @reputations = Kaminari.paginate_array(
                              @user.reputations.resources.in(type: types)
                            ).page(params[:page]).per(10)
    @reputation_types = ['评分']
    @partial_path = 'nodes'
    render template: 'users/show'
  end



  protected
  def get_reputable
    @reputable = params[:reputable_type].constantize.find(params[:reputable_id])
  end
end
