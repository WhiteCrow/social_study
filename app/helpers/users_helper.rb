module UsersHelper
  def whos(string)
    if current_user.present? and current_user == @user
      '我' + string
    else
      @user.name + string
    end
  end
end
