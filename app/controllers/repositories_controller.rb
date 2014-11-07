class RepositoriesController < ApplicationController
require 'json'

  def index
    # @user = params[:keyword]
    # repos = `curl https://api.github.com/users/#{user_name}/repos`
    # @repositories = JSON.parse(repos)
  end

  def show
    repo_name = params["name"]
    owner = current_user.username
    repo_commits = `curl https://api.github.com/repos/#{owner}/#{repo_name}/commits`
    @commits = JSON.parse(repo_commits)
  end

  def new
  	@repository = Repository.new
  end

  def create
  	@repository = Repository.new(repository_params)
  	if @repository.save
  		flash[:success]
  		redirect_to @repository
  	else
  		flash[:error]
  		redirect_to 'new'
  	end
  end

  def search
    @user = params[:keyword]
    @repos = `curl -i https://api.github.com/users/"#{@user}"/repos`
    #redirect_to '/'
    #binding.pry
    #@repositories = JSON.parse(@repos)
    #binding.pry
    redirect_to repositories_path
  end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name, :user_id)
  end

end
