class UserMailer < ActionMailer::Base
  default :from => "saranya.mohanbaba@sedin.co.in"  
  def registration_confirmation(user) 
      @user=user
    mail(:to => user.email, :subject => "Registered")  
  end  
  
  def send_forgot_password(user)
    @user=user
    mail(:to => user.email, :subject => "you are Registered",        :from => "mailer1@railsfactory.com")  
                       
  end
  
   def forgot_password(user)
      @user=user
      mail(:to => user.email, :subject => "to change password",        :from => "saranya.mohanbaba@sedin.co.in")  
      #  @body[:url]  = "#{SITE}/reset_password/}" 
   end
      
end
