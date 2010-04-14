# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include TrackmydietHelper
  
  before_filter :check_authorization
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # Pick a unique cookie name to differentiate our session data from others
  session :session_key => '_track_my_diet_session_id'
  
  # Check for a valid authorization cookie
  def check_authorization
	authorization_token = cookies[:authorization_token]
	if authorization_token and not logged_in?
		user = User.find_by_authorization_token(cookies[:authorization_token])
		user.login!(session) if user
	end
  end
end
