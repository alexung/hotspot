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
    repository = Repository.find_by(name: params[:repository], owner_name: params[:username])
    rows = CodeReview.new(params[:repository], params[:username]).rows
    rows.each do |repo_file|
      if file = repository.repository_files.find_by(name: repo_file.name)
        file.update(repo_file)
      else
        repository.repository_files.create(repo_file)
      end
    end
  end

  def change_branch
    repository = Repository.find_by(name: params[:repository], owner_name: params[:username])
    saved_repository = Repository.save_repository_to_db(params[:username], repository, params[:uid], session[:user_id], branches)
    rows = CodeReview.new(repository, params[:username], params[:branch])
    rows.map do |repo_file|
      RepositoryFile.create_repo_files(repo_file, params[:username], saved_repository)
    end
    @repository = saved_repository
    render 'repositories/show'
  end

  def destroy
    repository = Repository.find(params[:id])
    delete_repo(repository.name)
    repository.destroy
    redirect_to user_path(User.find(session[:user_id]))
  end
end
