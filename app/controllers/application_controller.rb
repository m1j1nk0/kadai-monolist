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


  def read(result)
    code = result["itemCode"]
    name = result["itemName"]
    url = result["itemUrl"]
    image_url = result["mediumImageUrls"].first["imageUrl"].gsub("?_ex=128x128","")
    
    return{
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end  
end
