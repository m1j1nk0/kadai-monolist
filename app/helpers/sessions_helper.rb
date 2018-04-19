module SessionsHelper
  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id])   #@current_userがnilだったら、右辺が実行される
  # end

  def logged_in?
    !!current_user  #!!→否定の否定、必ずtrueかfalseが返る
  end
end