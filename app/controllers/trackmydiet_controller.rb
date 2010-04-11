class TrackmydietController < ApplicationController
  
  def index
	@title = "Welcome to TrackMyDiet"
  end

  def about
	@title = "About TrackMyDiet"
  end
  
  def nutrition
	@title = "TrackMyDiet Nutrition"
  end
  
  def exercise
	@title = "TrackMyDiet Exercise"
  end
  
  def communities
	@title = "TrackMyDiet Communities"
  end
  
end
