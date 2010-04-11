class User < ActiveRecord::Base
	
	attr_accessor :remember_me
	
	# Max & min lengths for all fields 
	SCREEN_NAME_MIN_LENGTH = 4 
	SCREEN_NAME_MAX_LENGTH = 20 
	PASSWORD_MIN_LENGTH = 4 
	PASSWORD_MAX_LENGTH = 40 
	EMAIL_MAX_LENGTH = 50 
	SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH 
	PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH 
	
	# Text box sizes for display in the views 
	SCREEN_NAME_SIZE = 20 
	PASSWORD_SIZE = 10 
	EMAIL_SIZE = 30 
	
	validates_presence_of	:firstname, :lastname, :username, :password, :email
	
	validates_uniqueness_of	:username, :email	


	validates_format_of		:username,	
							:with	=> /^[A-Z0-9_]*$/i,
							:message => "must contain only letters," + 
										" numbers and underscores"
										
	validates_length_of :email, :maximum => EMAIL_MAX_LENGTH 										
										
	validates_length_of :username, :firstname, :lastname, :within => SCREEN_NAME_RANGE
	
	validates_length_of :password, :within => PASSWORD_RANGE 
	
	validates_format_of :email, 
						:with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i, 
						:message => "must be a valid email address"	
	
	
	# Method to track a logged-in user
	def login!(session)
		session[:user_id] = id
	end
	
	# Log out a user
	def self.logout!(session)
		session[:user_id] = nil
	end
	
	# Clear Password
	def clear_password!
		self.password = nil
	end
end