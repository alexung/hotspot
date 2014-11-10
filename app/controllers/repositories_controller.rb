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
  end

  def new_code_review
    @individual_repo_banner = true
    @notes = Note.all
    @username = params[:username]
    @repository = params[:repo]
    @branches = list_branches(@repository)
    repo_uid = params[:uid]

    @rows = CodeReview.new(@repository, @username).rows

    saved_repository = Repository.save_repository_to_db(@username, @repository, repo_uid, session[:user_id])
    @rows.map do |repo_file|
      RepositoryFile.create_repo_files(repo_file, @username, saved_repository)
    end
    @rows.sort_by{|row_arr| -row_arr[:commits]}
    render :show
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
   params.require(:repository).permit()
  end
end
