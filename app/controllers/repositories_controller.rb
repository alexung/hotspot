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
    @rows = CodeReview.new(@repository, @username).rows.sort_by{|row_arr| -row_arr[:commits]}
    render :show
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

  private

  def repository_params
  	params.require(:repository).permit(:url, :name)
  end
end
