class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :existing_topics
  rescue_from ActiveRecord::RecordNotFound, :with => :someredirect

  def existing_topics
     Topic.all
  end

  def someredirect
    redirect_to root_path
  end

end
