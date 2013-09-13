class StatesController < ApplicationController
  before_filter :require_user, except: [:show, :index]
  layout 'main', except: [:index]

  def index
    if current_user
      @microblog = Microblog.new
      @states = Audit.state.
                      in(:modifier => [current_user] + current_user.following).
                      desc('created_at').
                      page(params[:page]||1).per(20)
      respond_to do |format|
        format.html
        format.js { render 'states/paginate' }
      end
    else
      respond_to do |format|
        format.html { render 'common/home', layout: 'blank' }
      end
    end
  end

  def show
    @state = Audit.find(params[:id])
    @statable = @state.statable
    @auditable = @state.auditable

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  def relay
    @statable = Audit.find(params[:id]).statable
    @auditable = Audit.find(params[:id]).auditable
    if @statable.user != current_user
      #user only can relay other users' statable
      if current_user.relay?(@statable)
        current_user.unrelay(@statable)
      else
        current_user.relay(@statable)
      end
      respond_to do |format|
        format.html{ render action: :show }
        format.js
      end
    end
  end

  def destroy
    @auditable = Audit.where(modifier_id: current_user.id).find(params[:id]).auditable
    @auditable.destroy

    respond_to do |format|
      format.js
    end
  end

end
