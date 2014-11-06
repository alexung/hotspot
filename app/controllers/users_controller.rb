class UsersController < ApplicationController

  def index
  end

  def show
  	@user = User.find(current_user)
  end

end
