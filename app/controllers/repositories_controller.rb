class RepositoriesController < ApplicationController
  include GithubHelper
  include ApplicationHelper
  include RepositoryHelper

  def show
    @repository = Repository.find(params[:id])
    @branches = list_branches(@repository.name)
    @rows = @repository.repository_files
  end

  def update
      # repository = Repository.find_by(repo_uid: repo_uid)
    username = params[:username]
    repository = Repository.find_by(name: params[:repository], owner_name: username)
    @rows = CodeReview.new(repository, username).rows

    @rows.each do |repo_file|
      if file = repository.repository_files.find_by(name: repo_file.name)
        file.update(params)
      else
        repository.repository_files.create(params)
          # FIGURE OUT DELETE of old/deleted files from repo
      end
    end
  end

  def destroy
    repository = Repository.find(params[:id])
    # delete from /tmp
    delete_repo(repository.name)
    repository.destroy
    redirect_to user_path(User.find(session[:user_id]))
  end

  private

  def repository_params
   params.require(:repository).permit()
  end
end
