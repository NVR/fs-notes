class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :existing_topics

  def existing_topics
     Topic.all
  end
  
end
