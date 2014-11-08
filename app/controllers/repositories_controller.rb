class RepositoriesController < ApplicationController
  include GithubHelper
  def index
    @user = params[:username]

    @repositories = fetch_gh_repos({:user => @user})
    @repositories.class
    if @repositories.class == Array
     render :index
    else
      flash[:error] = "No user was found with that username."
      redirect_to root_path
    end
  end

  def show
    @repository = params[:repo]
    @username = params[:username]

    #success! saving repo to database
    @repository_to_database = Repository.new(user_id: 1, name: params[:repo], url: "http://www.github.com/#{@username}/#{@repository}")
    @repository_to_database.save

    #success! Saving repofiles to database
    @rows_to_parse = CodeReview.new(@repository, @username).rows
    @rows_to_parse.map do |path|
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

  private

  def repository_params
  	params.require(:repository).permit(:url, :name)
  end
end
