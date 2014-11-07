class UsersController < ApplicationController

  def index
  end

  def show
  	@user = User.find(current_user)
  end

  def search
  	@user = params[:keyword]
  	puts "-----------------------------------------"
  	puts @user
  end

end
