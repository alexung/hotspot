class NotesController < ApplicationController

  def new
    @note = Note.new
  end

  def create
    p params
    #u = request.original_url
    #p = CGI.parse(u.query)
    @username = params["note"]["user_id"]
    @repository = params["note"]["repository_id"]
    @repo = Repository.find_by(name: params["note"]["repository_id"])
    @note = Note.new(notes_params)
    @note.user_id = session[:user_id]
    @note.save
      redirect_to "/code-review?username=#{@username}&repo=#{@repository}"
  end

  private

  def notes_params
    params.require(:note).permit(:content, :user_id, :repository_id)
  end

end
