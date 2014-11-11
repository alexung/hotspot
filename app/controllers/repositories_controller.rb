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
    rows = CodeReview.new(repository.name, User.find(repository.user_id).name).rows
    rows.each do |repo_file|
      if file = repository.repository_files.find_by(name: repo_file.name)
        file.update(repo_file)
      else
        repository.repository_files.create(repo_file)
      end
    end
  end

  def destroy
    repository = Repository.find(params[:id])
    delete_repo(repository.name)
    repository.destroy
    redirect_to user_path(User.find(session[:user_id]))
  end
end
