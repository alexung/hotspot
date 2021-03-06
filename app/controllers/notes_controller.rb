class NotesController < ApplicationController

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @username = params["note"]["username"]
    @repository = params["note"]["repository_name"]
    @repo = Repository.find_by(name: params["note"]["repository_name"])
    @note = Note.new(notes_params)
    @note.repo_uid = @repo.repo_uid
    @note.user_id = session[:user_id]
    @note.save
    redirect_to repository_path(Repository.find(@repo.id))
  end

  private

  def notes_params
    params.require(:note).permit(:content, :user_id, :repo_uid)
  end

end
