class NotesController < ApplicationController
  helper_method :editable?, :not_current?
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :page_exceedance?
  before_filter :can_edit?, :only => [:edit, :delete]
  
  def page_exceedance?
    if params[:page].to_i > Note.pages_count
      params[:page] = (Note.pages_count).to_s
    end
  end

  def topics
    if params[:topic_id].present?
      @topic = Topic.find(params[:topic_id])
      if params[:search].present?
        @notes = Topic.find(params[:topic_id]).notes.search(params[:search])
        @count = @notes.count
        @notes = @notes.page(params[:page])
      else
        @notes = Topic.find(params[:topic_id]).notes.page(params[:page])
        @count = Topic.find(params[:topic_id]).notes.count
      end
    end
    @title = "Notes associated with #{@topic.name}"
  end

  def index
    if params[:search].present?
      @notes = Note.search(params[:search])
      @count = @notes.count
      @notes = @notes.page(params[:page])
    else
      @notes = Note.page(params[:page])
      @count = Note.count
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @preview = false
    @note = Note.new
    @title = 'New note'
  end

  def edit
    @note = Note.find(params[:id])
    @title = 'Edit note'
    @preview = false
  end

  def create
    @note = current_user.notes.build(params[:note])
    #@note = Note.new(params[:note])
    @title = 'New note'

    if params[:commit] == "Preview"
      @preview = true
      render action: 'new'
    elsif params[:commit] == "Back"
      @preview = false
      render action: 'new'
    else
      if @note.save
        redirect_to @note, notice: 'Note was successfully created.' 
      else
        render action: "new" 
      end
    end
  end

  def update
    @note = Note.find(params[:id])
    if params[:commit] == "Preview"
      @note.update_attributes(params[:note])
      @preview = true
      render action: "edit"
    elsif params[:commit] == "Back"
      @preview = false
      render action: "edit"
    else
      if @note.update_attributes(params[:note])
        redirect_to @note, notice: 'Note was successfully updated.'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to notes_url
  end

  def not_current?(note)
    note.id == params[:id].to_i
  end

  def search
    @searchresult = Note.search(params[:search])
  end

  private

    def can_edit?
      @note = Note.find(params[:id])
      unless editable?(@note)
        redirect_to @note , notice: "You can't edit other people's notes."
      end
    end

    def editable?(note)
      user_signed_in? && (current_user.id == note.user_id)
    end

end
