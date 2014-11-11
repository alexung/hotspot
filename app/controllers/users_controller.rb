class UsersController < ApplicationController
  include ApplicationHelper

  def show
    @user = User.find(session[:user_id])
    @repositories = @user.repositories
  end

	private

	def user_params
		params.require(:user).permit(:avatar_url, :email, :name)
	end
end
