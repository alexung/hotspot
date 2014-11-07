class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
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
