class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all
  end

end
