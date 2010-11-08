class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
    
  include AuthenticatedSystem


  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
     
      UserMailer.registration_confirmation(@user).deliver  
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/login', :notice => "Thanks for signing up!  We're sending you an email .")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def forgot_password
    
  end
  
  def sendpassword
  
    if @user = User.find_by_email(params[:user][:email])
	      
		
		
      @user.update_attribute(:password_reset_code, Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join ))
      
      UserMailer.forgot_password(@user).deliver
      @user.save
      redirect_back_or_default('/login')
      flash[:notice] = "A password reset link has been sent to your email address" 
	
     
    else
          flash[:alert] = "Could not find a user with that email address" 
          render :action=>'forgot_password'
    end 
  end


  def confirm_create
	  puts params.inspect
	  puts "-------co----------"
    puts params[:password_reset_code].inspect
	  puts params[:id].class.inspect
    @us=params[:id]
                        
    @user=User.find_by_password_reset_code(@us)
    puts @user.name
    @username=@user.name
    puts "tttttttttt#{params[:password]}iiiiiiii"
           
  end
  
  
  def password_reset
    
   if ((params[:password] && params[:password_confirmation]) && !params[:password_confirmation].blank?)
                       
        @use=User.find_by_name(params[:username])
        puts @use.inspect
                                         
        if @use.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
          @use.save                                            
          redirect_to '/login'
        else 
          flash.now[:error] = "cant be blank" 
          render :action=>'forgot_password'
                                           
        
        end
    else
                                                  
      render :action=>'confirm_create'
    end
			
  end
end
