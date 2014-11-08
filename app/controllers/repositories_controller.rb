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
    @rows = CodeReview.new(@repository, @username).rows
    render :show
  end

  # def show_lynxshare
  #   @rows = LynxShare.new.rows
  #   render :show
  # end

  # def get_code_review
  #   repository = params[:repo_name]
  #   @rows = CodeReview.new(repository).rows
  #   render :show
  # end

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
    @user = params[:username]
    # @repos = `curl -i https://api.github.com/users/"#{@user}"/repos`
    # redirect_to '/'
    # @repositories = JSON.parse(@repos)
    redirect_to :controller => 'repositories', action: 'index', username: params[:username]
  end

  private

  def repository_params
  	params.require(:repository).permit(:url, :name, :user_id)
  end

end
