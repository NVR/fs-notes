class TopicsController < ApplicationController

  def show
    @topic = Topic.find(params[:id])
    if params[:search].present?
      @notes = Topic.find(params[:id]).notes.search(params[:search])
      @count = @notes.count
      @notes = @notes.page(params[:page])
    else
      @notes = Topic.find(params[:id]).notes.page(params[:page])
      @count = Topic.find(params[:id]).notes.count
    end
    @title = "Notes associated with #{@topic.name}"
  end

  def index
  end

end
