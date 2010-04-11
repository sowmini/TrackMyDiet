class UserController < ApplicationController
  
  include TrackmydietHelper
  
  layout 'trackmydiet'
  before_filter :protect, :only => :index
  
  def index
	@title = "Track My diet"
  end

  def register
	@title = "Register"
	# Refer user model for the method 'param_posted' functionality
	if param_posted?(:user)
      @user = User.new(params[:user]) 
	  
      if @user.save 
        @user.login!(session)
		flash[:notice] = "User #{@user.username} created!" 
		# Performs necessary redirections after validating the redirect_url
		redirect_to_forwarding_url
	  else
		# Refer user model for the method functionality
		@user.clear_password!
      end 
    end 
  end
  
  def login
	@title = "Login to TrackMyDiet"
	
	if request.get?
		@user = User.new(:remember_me => cookies[:remember_me] || "0")
	elseif param_posted?(:user)
		@user = User.new(params[:user])
		user = User.find_by_username_and_password(@user.username, @user.password)
		
		if user
			user.login!(session)
			
			#Remember user credentials
			if @user.remember_me == "1"
				#Checkbox selected, so set the remember_me cookie
				cookies[:remember_me] = { :value   => "1", 
										  :expires => 10.years.from_now}
			end
			
			flash[:notice] = "User #{user.username} logged in!"
			# Performs necessary redirections after validating the redirect_url
			redirect_to_forwarding_url
			
		else
			# Dont show the password in view
			@user.clear_password!
			flash[:notice] = "Invalid username/password combination"
		end
	end
  end
  
  def logout
	# Refer user model for the method 'logout!' functionality 
	User.logout!(session)
	flash[:notice] = "Logged out!"
	redirect_to :action => "index", :controller => "trackmydiet"
  end
  
  private
  def protect
	# Refer user model for the method 'logged_in?' functionality
	unless logged_in?
		session[:protected_page] = request.request_uri
		flash[:notice] = "Please login first"
		redirect_to :action => "login", :controller => "user"
		return false
	end
  end
  
  # Returns true if a parameter corresponding to the given symbol was posted
  def param_posted?(symbol)
	request.post? and params[symbol]
  end
  
  
  def redirect_to_forwarding_url
		if (redirect_url = session[:protected_page] )
			session[:protected_page] = nil
			redirect_to redirect_url
		else
			redirect_to	:action => "index"
		end
	end
end
