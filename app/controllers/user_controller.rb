
class UserController < ApplicationController
  
  include TrackmydietHelper
  
  layout 'trackmydiet'
  
  # To allow only a logged-in user to edit
  before_filter :protect, :only => [:index, :edit]
  
  def index
	@title = "Track My diet"
	@user = User.find(session[:user_id])
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
		@user = User.new(:remember_me => remember_me_string)
	elsif param_posted?(:user)
		@user = User.new(params[:user])
		user = User.find_by_username_and_password(@user.username, @user.password)
		
		if user
			# Check if the user is logged in
			user.login!(session)
			
			# Remember user credentials
			if @user.remember_me?
				# Checkbox selected, so set the remember_me cookie
				# Refers the remember action in user model
				user.remember!(cookies)
			else
				user.forget!(cookies)
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
	User.logout!(session, cookies)
	flash[:notice] = "Logged out!"
	redirect_to :action => "index", :controller => "trackmydiet"
  end
  
  def edit
	@title = "Edit Profile info"
	@user = User.find(session[:user_id])
	if param_posted?(:user)
		if @user.update_attributes(params[:user])
			flash[:notice] = "Email updated"
			redirect_to :action => "index"
		end
	end
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
  
  def remember_me_string
	cookies[:remember_me] || "0"
  end
  
end
