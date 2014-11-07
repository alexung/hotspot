class RepositoriesController < ApplicationController
require 'json'
  def index
    y = `curl -i https://api.github.com/repos/alexung/dine-with-me/commits`
    @stuff = JSON.parse(y)
    binding.pry
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

  private

  def repository_params
  	params.require(:repository).permit(:url, :name, :user_id)
  end

end
