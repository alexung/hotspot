class RepositoriesController < ApplicationController
  include GithubHelper

  def index
    @user = params[:username]
    @repositories = fetch_gh_repos(@user)
  end

  def show
    @repository = params[:repo]
    @username = params[:username]
    @contributers = fetch_gh_contributors(@username, @repository)
    @avatars = @contributers.fetch_contributor_avatar

    #success! saving repo to database
    @repository_to_database = Repository.new(user_id: 1, name: params[:repo], url: "http://www.github.com/#{@username}/#{@repository}")
    @repository_to_database.save

    #success! Saving repofile to database
    @rows_to_parse = CodeReview.new(@repository, @username).rows
    @rows_to_parse.map do |path|
      RepositoryFile.create(
                            github_url: "http://github.com/#{@username}/#{@repository}/blob/master/#{path[:file_path]}",
                            commits: path[:commits],
                            contributers: path[:contributers].to_s,
                            insertions: path[:insertions],
                            deletions: path[:deletions]
                            )
    end

    @rows = CodeReview.new(@repository, @username).rows.sort_by{|row_arr| -row_arr[:commits]}

    render :show
  end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name)
  end
end
