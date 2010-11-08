require 'authenticated_system.rb'
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private 
  def authenticate 
    authenticate_or_request_with_http_basic do |user_name, password| 
      user_name == 'admin' && password == 'password'  
    end 
  end 
  
 def require_login

     unless logged_in? 
     flash[:error] = "You must be logged in to access this section" 
     redirect_to new_session_url # halts request cycle 
    end  
  end 

  def logged_in?
    !!current_user
  end
end
