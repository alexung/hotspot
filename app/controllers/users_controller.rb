class UsersController < ApplicationController

	def index
	end

	def show
		@user = User.find(current_user)
	end

	def latest_commits(limit = 6)
		latest = self.commits.includes(:branch).order(created_at: :desc).limit(limit)
	end

	def json_info
		my_user = {}
		my_user[:main_info] = self
		my_user[:latest_commits] = self.latest_commits
		my_user
	end

	private

	def user_params
		params.require(:user).permit(:avatar_url, :email, :name, :token, :uid)
	end
end
