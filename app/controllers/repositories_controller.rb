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
      redirect_to user_path(User.find(session[:user_id].id))
    end
  end

  def show
    #@saved_repositories_banner = false
    @individual_repo_banner = true
    @notes = Note.all
    @repository = params[:repo]
    @branches = list_branches(@repository)
    @username = params[:username]
    repo = JSON.parse(`curl https://api.github.com/repos/#{@username}/#{@repository}`)
    @repo_uid = repo["id"]

    if repository_exists?(@repository, @username)
      repository = Repository.find_by(repo_uid: @repo_uid)
      @repo_uid = repository.repo_uid #this keeps track of the repo_uid for later use when we recreate the repository below.
      # binding.pry
      repository.destroy
    end

    #success! saving repo to database
    @repository_to_database = Repository.new(user_id: session[:user_id, name: params[:repo], url: "http://www.github.com/#{@username}/#{@repository}", repo_owner: @username, repo_uid: @repo_uid)
    @repository_to_database.save

    delete_repo(@repository)

    #success! Saving repofiles to database
    @rows_to_parse = CodeReview.new(@repository, @username)
    # @rows_to_parse.rows
    # binding.pry
    @rows_to_parse.rows.map do |path|
      RepositoryFile.create(
                            github_url: "http://github.com/#{@username}/#{@repository}/blob/master/#{path[:file_path]}",
                            repository_id: @repository_to_database.id,
                            name: @repository_to_database.name,
                            commits: path[:commits],
                            contributers: path[:contributers].to_s,
                            insertions: path[:insertions],
                            deletions: path[:deletions]
                            )
    end

    @rows = CodeReview.new(@repository, @username).rows.sort_by{|row_arr| -row_arr[:commits]}
  end

  def change_branch
    @branch = params[:branch]
  end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name)
  end
end
