class RepositoriesController < ApplicationController
  include GithubHelper
  include ApplicationHelper
  include RepositoryHelper
  require 'json'

  def index
    @saved_repositories_banner = true
    @notes = Note.all
    @user = params[:username]

    @repositories = fetch_gh_repos(@user)
    if @repositories.class == Array
      render :index
    else
      flash[:error] = "No user was found with that username."
      redirect_to user_path(User.find(session[:user_id]))
    end
  end

  def show
    @individual_repo_banner = true
    @notes = Note.all
    @repository = params[:repo]
    @branches = list_branches(@repository)
    @username = params[:username]
    repo_uid = fetch_repo_uid(username, repository)

    @rows = CodeReview.new(@repository, @username).rows

    save_repository_to_db(@username, @repository, repo_uid)
    
    @rows.map do |path|
      RepositoryFile.create_repo_files(path, @username, repository_to_database)
    end
    @rows.sort_by{|row_arr| -row_arr[:commits]}
  end

  def update
    if repository_exists?(repo_uid)
      repository = Repository.find_by(repo_uid: repo_uid)
      repository.destroy
    end
    
  end

  def destroy
  end

  def change_branch
    @branch = params[:branch]
    @repository = params[:repo]
    @branches = list_branches(@repository)
    @username = params[:user]
    @rows = CodeReview.new(@repository, @username, @branch).rows.sort_by{|row_arr| -row_arr[:commits]}
    render :show
  end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name)
  end
end
