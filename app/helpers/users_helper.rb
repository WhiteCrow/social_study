module UsersHelper
  def whos(string)
    if current_user.present? and current_user == @user
      '我的' + string
    else
      @user.name + '的' + string
    end
  end
end
