class NotesController < ApplicationController
  before_filter :authenticate_user!, :except =>[:index, :show]

  def index
    @notes = Note.all
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
    @title = 'New note'
  end

  def edit

    @note = Note.find(params[:id])
    @title = 'Edit note'
  end

  def create
    @note = current_user.notes.build(params[:note])
    #@note = Note.new(params[:note])
    @title = 'New note'
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @note = Note.find(params[:id])
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
    end
  end
end
