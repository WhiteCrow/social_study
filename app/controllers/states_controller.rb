class StatesController < ApplicationController
  before_filter :require_user, except: [:show]
  layout 'main', except: [:index]

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
    @auditable = Audit.find(params[:id]).auditable
    @auditable.destroy

    respond_to do |format|
      format.js
    end
  end

end
