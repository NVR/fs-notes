class TopicsController < ApplicationController
  def show
    redirect_to topic_notes_path(params[:id])
  end
end
