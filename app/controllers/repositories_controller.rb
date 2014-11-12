class RepositoriesController < ApplicationController
  include GithubHelper
  include ApplicationHelper
  include RepositoryHelper
  include CodeReviewHelper

  def create
    @notes = Note.find_by(repository_id: params[:repository_id])
    redirect_to repository_path(params[:repository_id])
  end

  def show
    @notes_banner = true
    @repository = Repository.find(params[:id])
  end

  def update
    repository = Repository.find(params["id"])
    # breaking directly below this line
    rows = CodeReview.new(repository.name, User.find(repository.user_id).github_username).rows
    ` cd /tmp && rm -rf #{repository.name} `
    repository.repository_files.destroy
    saved_repository = Repository.save_repository_to_db(repository.name, User.find(repository.user_id).github_username, repository.repo_uid, session[:user_id])
    rows.each do |repo_file|
        file = repository.repository_files.find_by(name: repo_file[:file_path])
        file.destroy
       # must have line here that removes it from tmp
       # have line here that readds it to tmp
        RepositoryFile.create(repository_id: params["id"], name: repo_file[:file_path], commits: repo_file[:commits].strip, insertions: repo_file[:insertions], deletions: repo_file[:deletions], contributors: repo_file[:contributors].to_s )
      end
    redirect_to repository_path(repository)
  end

  def destroy
    repository = Repository.find(params[:id])
    delete_repo(repository.name)
    repository.destroy
    redirect_to user_path(User.find(session[:user_id]))
  end
end
