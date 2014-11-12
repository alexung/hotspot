class RepositoriesController < ApplicationController
  include GithubHelper
  include ApplicationHelper
  include RepositoryHelper

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
    rows.each do |repo_file|
      if file = repository.repository_files.find_by(name: repo_file[:file_path])
        file.update(name: repo_file[:file_path], commits: repo_file[:commits], insertions: repo_file[:insertions], deletions: repo_file[:deletions], contributors: repo_file[:contributors].to_s )
      else
        repository.repository_files.create(name: repo_file[:file_path], commits: repo_file[:commits], insertions: repo_file[:insertions], deletions: repo_file[:deletions], contributors: repo_file[:contributors].to_s)
      end
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
