class NotesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :page_exceedance?
  before_filter :permission2edit?, :only =>[:edit,:delete]

  def permission2edit?
    @note = Note.find(params[:id])
    if !(current_user.id == @note.user_id)
    render action: 'show'
    end
  end

  def page_exceedance?
    if params[:page].to_i > Note.pages_count
      params[:page] = (Note.pages_count).to_s
    end
  end

  def index
    @notes = Note.page(params[:page])
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
end
