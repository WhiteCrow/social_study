class StatesController < ApplicationController
  def show
    @state = Audit.find(params[:id])
    @statable = @state.statable

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  def relay
    @statable = Audit.find(params[:id]).statable
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



end
