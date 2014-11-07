class RepositoriesController < ApplicationController
require 'json'
  
  def index
    repos = `curl https://api.github.com/users/alexung/repos`
    @repositories = JSON.parse(repos)
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
    @user = params[:search]
    redirect_to '/'
  end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name, :user_id)
  end

end
