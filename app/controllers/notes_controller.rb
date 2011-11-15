class NotesController < ApplicationController
  helper_method :editable?, :not_current?
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :page_exceedance?
  before_filter :can_edit?, :only => [:edit, :delete]
  expose(:note) do
    note = (params[:id].present?) ? Note.find(params[:id]) : current_user.notes.build(params[:note])
  end
  expose :topic
  expose :user
  expose(:notes) do
    notes_with_scope = (params[:topic_id].present?) ? topic.notes : Note.scoped.order("created_at  DESC")
    Rails.logger.debug
    notes_with_scope = user.notes if params[:user_id].present?
    notes_with_scope = notes_with_scope.search(params[:search]) if params[:search].present?
    notes_with_scope
  end

  def index
    @count = notes.count
    @notes = notes.page(params[:page])
  end

  def show
  end

  def new
    @preview = false
    @title = 'New note'
  end

  def edit
    @title = 'Edit note'
    @preview = false
  end

  def create
    @title = 'New note'
    if params[:commit] == "Preview"
      @preview = true
      render action: 'new'
    elsif params[:commit] == "Edit"
      @preview = false
      render action: 'new'
    else
      if note.save
        redirect_to note, notice: 'Note was successfully created.' 
      else
        render action: "new" 
      end
    end
  end

  def update
    if params[:commit] == "Preview"
      note.update_attributes(params[:note])
      @preview = true
      render action: "edit"
    elsif params[:commit] == "Edit"
      @preview = false
      render action: "edit"
    else
      if note.update_attributes(params[:note])
        redirect_to note, notice: 'Note was successfully updated.'
      else
        render action: "edit"
      end
    end
  end

  def destroy
    note.destroy
    redirect_to notes_url
  end

  def not_current?(note)
    note.id == params[:id].to_i
  end

  private

  def can_edit?
    unless editable?(note)
      redirect_to note , notice: "You can't edit other people's notes."
    end
  end

  def editable?(note)
    user_signed_in? && (current_user.id == note.user_id)
  end

  def page_exceedance?
    if params[:page].to_i > Note.pages_count
      params[:page] = (Note.pages_count).to_s
    end
  end

end
