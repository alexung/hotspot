class RepositoriesController < ApplicationController
  require 'json'

  def index
    @user = params[:username]
    @repos = `curl https://api.github.com/users/#{@user}/repos?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}`
    @repositories = JSON.parse(@repos)
  end

  def show
    @repository = params[:repo]
    @username = params[:username]

    #success! saving repo to database
    @repository_to_database = Repository.new(user_id: 1, name: params[:repo], url: "http://www.github.com/#{@username}/#{@repository}")
    @repository_to_database.save

    #success! Saving repofile to database
    @rows = CodeReview.new(@repository, @username).rows
    @rows.map do |path|
      RepositoryFile.create(
                            github_url: "http://github.com/#{@username}/#{@repository}/blob/master/#{path[:file_path]}",
                            commits: path[:commits],
                            contributers: path[:contributers].to_s,
                            insertions: path[:insertions],
                            deletions: path[:deletions]
                            )
    end

    render :show
  end

  # def new
  # 	@repository = Repository.new
  # end

  # def create
  # 	@repository = Repository.new(repository_params)
  #   @repository.user = session.user_id
  # 	if @repository.save
  # 		flash[:success]
  # 		redirect_to @repository
  # 	else
  # 		flash[:error]
  # 		redirect_to 'new'
  # 	end
  # end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name)
  end
end
