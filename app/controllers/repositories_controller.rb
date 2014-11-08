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

    @repository_to_database = Repository.new(user_id: 1, name: params[:repo], url: "http://www.github.com/#{@username}/#{@repository}")
    @repository_to_database.save

    @repository_file_to_database = RepositoryFile.new(github_url: )
    @repository_file_to_database.save

    @rows = CodeReview.new(@repository, @username).rows
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
