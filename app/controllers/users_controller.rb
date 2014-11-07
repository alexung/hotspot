class UsersController < ApplicationController

	def index
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:avatar_url, :email, :name, :token, :uid)
	end
end
