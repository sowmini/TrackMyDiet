class ProfileController < ApplicationController

  layout 'trackmydiet'

  def index
	@title = "TrackMyDiet Profiles"
  end

  def show
	username = params[:username]
	@user = User.find_by_username(username)
	if @user
		@title = "My TrackMyDiet Profile for #{username}"
	else
		flash[:notice] = "No user #{username} at TrackMyDiet!"
		redirect_to :action => "index"
	end
	end
end
