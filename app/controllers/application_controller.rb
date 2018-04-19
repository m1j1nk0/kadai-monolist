class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end  
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])   #@current_userがnilだったら、右辺が実行される
  end    
  
end
