class RepositoriesController < ApplicationController
require 'json'

  def index
    @user = params[:keyword]
    @repos = `curl https://api.github.com/users/#{@user}/repos?client_id=891ce1a4c1d52b232e3d&f216b8fad1efd3cddc36f8fe7831c7aadbb9e4fd`
    @repositories = JSON.parse(@repos)
  end

  def show
    repo_name = params["name"]
    owner = current_user.username
    repo_commits = `curl https://api.github.com/repos/#{owner}/#{repo_name}/commits?client_id=#{ENV['GITHUB_KEY']}&#{ENV['GITHUB_SECRET']}`
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
    # @repos = `curl -i https://api.github.com/users/"#{@user}"/repos`
    # redirect_to '/'
    # @repositories = JSON.parse(@repos)
    redirect_to :controller => 'repositories', action: 'index', keyword: params[:keyword]
  end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name, :user_id)
  end

end
