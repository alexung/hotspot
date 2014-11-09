class NotesController < ApplicationController

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(notes_params)
    @note.user_id = session[:user_id]
    @note.save
      redirect_to root_path
  end

  private

  def notes_params
    params.require(:note).permit(:content, :user_id, :repository_id)
  end

end
